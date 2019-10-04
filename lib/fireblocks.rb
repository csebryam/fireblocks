# frozen_string_literal: true

require 'fireblocks/version'
require 'fireblocks/configuration'
require 'fireblocks/api/api'
require 'fireblocks/api/request'
require 'fireblocks/api/token'

# Parent module for all classes
module Fireblocks
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end
  end
end
