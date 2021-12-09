require 'refinements/string'
require 'smart_properties'

module Fireblocks
  class Type
    using Fireblocks::Refinements::String
    include SmartProperties
  end
end
