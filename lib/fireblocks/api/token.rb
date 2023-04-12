# frozen_string_literal: true

require 'digest'
require 'jwt'
require 'openssl'

module Fireblocks
  # This class will issue a new Fireblocks token
  class Token
    class << self
      def call(body, uri, config)
        new(body, uri, config).call
      end
    end

    attr_accessor :body, :uri

    def initialize(body, uri, config)
      @body = body
      @uri = uri
      @config = config
    end

    def created_at
      Time.now.to_i
    end

    def expire_at
      Time.now.to_i + 55
    end

    def call
      JWT.encode jwt_headers, rsa_private, 'RS256', typ: 'JWT'
    end

    def body_hash
      Digest::SHA256.hexdigest(body.to_json)
    end

    def decode_token
      JWT.decode token, rsa_private.public_key, true, algorithm: 'RS256'
    end

    def jwt_headers
      {
        uri: uri.request_uri,
        nonce: nonce,
        iat: created_at,
        exp: expire_at,
        sub: @config.api_key,
        bodyHash: body_hash
      }
    end

    def nonce
      "#{Time.now.to_i}#{Time.now.nsec}".to_i
    end

    def rsa_private
      OpenSSL::PKey::RSA.new(@config.private_key)
    end
  end
end
