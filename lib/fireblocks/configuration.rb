# frozen_string_literal: true

# Global configuration settings for the gem
module Fireblocks
  #
  # base_url is set to a default but can be configured
  #
  class Configuration
    Error = Class.new(StandardError)
    attr_writer :api_key, :private_key

    attr_accessor :base_url, :tenant_id, :read_timeout_value

    def initialize
      @api_key = nil
      @private_key = nil
      @tenant_id = nil
      @base_url = 'https://api.fireblocks.io'
      @read_timeout_value = 0.0001
    end

    def api_key
      message =
        'Fireblocks api key not set. See Fireblocks documentation ' \
        'to get a hold of your api key'
      raise Error, message unless @api_key

      @api_key
    end

    def private_key
      message =
        'Fireblocks private key not set. See Fireblocks documentation ' \
        'to get a hold of your private key'
      raise Error, message unless @private_key

      @private_key
    end
  end
end
