require 'plissken'

module Fireblocks
  module Types
    class Response < Type
      include Plissken::Methods

      alias to_hash to_camel_keys
      alias to_h to_camel_keys
    end
  end
end
