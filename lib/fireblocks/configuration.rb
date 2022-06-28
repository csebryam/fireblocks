# frozen_string_literal: true

# Global configuration settings for the gem
module Fireblocks
  #
  # base_url is set to a default but can be configured
  #
  class Configuration
    Error = Class.new(StandardError)
    attr_writer :api_key, :private_key, :api_key_old_primetrust, :private_key_old_primetrust

    attr_accessor :base_url, :tenant_id

    def initialize
      @api_key = nil
      @private_key = nil
      @tenant_id = nil
      @api_key_old_primetrust = nil
      @private_key_old_primetrust = nil
      @base_url = 'https://api.fireblocks.io'
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

    def api_key_old_primetrust
      message =
        'Fireblocks api key for old workspace not set. See Fireblocks documentation ' \
        'to get a hold of your api key'
      raise Error, message unless @api_key_old_primetrust

      @api_key_old_primetrust
    end

    def private_key_old_primetrust
      message =
        'Fireblocks private key for old workspace not set. See Fireblocks documentation ' \
        'to get a hold of your private key'
      raise Error, message unless @private_key_old_primetrust

      @private_key_old_primetrust
    end
  end
end
