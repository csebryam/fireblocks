# frozen_string_literal: true

require 'digest'
require 'jwt'
require 'openssl'

module Fireblocks
  # This class will issue a new Fireblocks token
  class Token
    CURRENT = 'CURRENT_WORKSPACE'
    OLD = 'OLD_WORKSPACE'

    class << self
      def call(body, uri, workspace: CURRENT)
        new(body, uri, workspace).call
      end
    end

    attr_accessor :body, :uri, :workspace

    def initialize(body, uri, workspace)
      @body = body
      @uri = uri
      @workspace = workspace
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
        sub: api_key,
        bodyHash: body_hash
      }
    end

    def nonce
      "#{Time.now.to_i}#{Time.now.nsec}".to_i
    end

    def rsa_private
      OpenSSL::PKey::RSA.new(private_key)
    end

    def api_key
      workspace == CURRENT ? current_workspace_api_key : old_workspace_api_key
    end

    def current_workspace_api_key
      Fireblocks.configuration.api_key
    end

    def old_workspace_api_key
      Fireblocks.configuration.api_key_old_primetrust
    end

    def private_key
      workspace == CURRENT ? current_workspace_private_key : old_workspace_private_key
    end

    def current_workspace_private_key
      Fireblocks.configuration.private_key
    end

    def old_workspace_private_key
      Fireblocks.configuration.private_key_old_primetrust
    end
  end
end
