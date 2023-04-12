# frozen_string_literal: true

require 'net/http'

module Fireblocks
  # Interface to GET, POST, PUT
  class Request
    Error = Class.new(StandardError)
    class << self
      def get(path:, body: '', config: nil)
        new(path: path, config: config).get(body)
      end

      def put(path:, body:, config: nil)
        new(path: path, config: config).put(body)
      end

      def post(path:, body:, config: nil)
        new(path: path, config: config).post(body)
      end
    end

    attr_accessor :path, :uri

    def initialize(path:, config: nil)
      @path = path
      @config = config || Fireblocks.configuration
      @uri = URI("#{@config.base_url}#{path}")
    end

    def get(body)
      req = Net::HTTP::Get.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }

      valid_response!(send_request(req))
    end

    def put(body)
      req = Net::HTTP::Put.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }
      req.body = body.to_json

      valid_response!(send_request(req))
    end

    def post(body)
      req = Net::HTTP::Post.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }
      req.body = body.to_json

      valid_response!(send_request(req))
    end

    private

    def request_headers(body)
      {
        'X-API-Key' => @config.api_key,
        'Authorization' => "Bearer #{token(body, @config)}",
        'Content-Type' => 'application/json'
      }
    end

    def send_request(request)
      Net::HTTP.start(
        uri.hostname, uri.port, use_ssl: true
      ) { |http| http.request(request) }
    end

    def token(body, config)
      Token.call(body, uri, config)
    end

    def valid_response!(req_response)
      resp = JSON.parse(req_response.body)
      return resp if req_response.message == 'OK'

      raise Error, resp
    end
  end
end
