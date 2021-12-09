require 'awrence'

module Fireblocks
  module Types
    class Request < Type
      include Awrence::Methods

      alias to_hash to_camelback_keys
      alias to_h to_camelback_keys
    end
  end
end
