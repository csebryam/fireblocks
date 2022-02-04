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

      def post(path:, body: {}, headers:)
        new(path: path).post(body, headers)
      end
    end

    attr_accessor :path, :uri, :idempotency_key

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

    def post(body, idempotency_key:)
      @idempotency_key = idempotency_key
      req = Net::HTTP::Post.new(uri)
      request_headers(body, idempotency_key).each { |rk, rv| req[rk] = rv }
      # request_headers(body, headers).each { |rk, rv| req[rk] = rv }
      req['Idempotency-Key'] = idempotency_key if idempotency_key
      req.body = body.to_json

      valid_response!(send_request(req), request: req)
    end

    private

    def request_headers(body, idempotency_key:)
    # def request_headers(body)
      {
        'X-API-Key' => Fireblocks.configuration.api_key,
        'Authorization' => "Bearer #{token(body)}",
        'Content-Type' => 'application/json',
        'Idempotency-Key' => idempotency_key
        # 'Idempotency-Key' => onchain_transaction.idempotency_key
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
        request_body: request.body,
        idempotency_key: request.idempotency_key
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
