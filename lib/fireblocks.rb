# frozen_string_literal: true

require 'fireblocks/version'
require 'fireblocks/configuration'
require 'fireblocks/type'
require 'fireblocks/types/response'
require 'fireblocks/types/request'
require 'fireblocks/types/vault/create_vault_asset_response'
require 'fireblocks/api/api'
require 'fireblocks/api/request'
require 'fireblocks/api/token'
require 'fireblocks/api/transactions'

module Fireblocks
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reload_configuration
    @configuration = Configuration.new
  end
end

