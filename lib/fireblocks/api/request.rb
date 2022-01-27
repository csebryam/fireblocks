# frozen_string_literal: true

require 'net/http'

module Fireblocks
  # Interface to GET, POST, PUT
  class Request
    class << self
      def get(path:, body: '')
        new(path: path).get(body)
      end

      def put(path:, body:)
        new(path: path).put(body)
      end

      def post(path:, body: {})
        new(path: path).post(body)
      end
    end

    attr_accessor :path, :uri

    def initialize(path:)
      @path = path
      @uri = URI("#{Fireblocks.configuration.base_url}#{path}")
    end

    def get(body)
      req = Net::HTTP::Get.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }

      valid_response!(send_request(req), request: req)
    end

    def put(body)
      req = Net::HTTP::Put.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }
      req.body = body.to_json

      valid_response!(send_request(req), request: req)
    end

    def post(body)
      req = Net::HTTP::Post.new(uri)
      request_headers(body).each { |rk, rv| req[rk] = rv }
      req.body = body.to_json

      valid_response!(send_request(req), request: req)
    end

    private

    def request_headers(body)
      {
        'X-API-Key' => Fireblocks.configuration.api_key,
        'Authorization' => "Bearer #{token(body)}",
        'Content-Type' => 'application/json',
        'Idempotency-Key' => SecureRandom.uuid
      }
    end

    def send_request(request)
      Net::HTTP.start(
        uri.hostname, uri.port, use_ssl: true
      ) { |http| http.request(request) }
    end

    def token(body)
      Token.call(body, uri)
    end

    def valid_response!(req_response, request:)
      resp = JSON.parse(req_response.body)
      return resp if %w[OK Created].include?(req_response.message)

      err_details = {
        code: req_response.code,
        message: req_response.message,
        response_body: req_response.body,
        method: request.method,
        path: request.path,
        request_body: request.body
      }

      raise Error.new(err_details)
    end

    class Error < StandardError
      attr_reader :error_details

      def initialize(error_details)
        @error_details = error_details
        super(error_details)
      end

      def fireblocks_response_json
        error_details[:response_body]
      end
    end
  end
end
