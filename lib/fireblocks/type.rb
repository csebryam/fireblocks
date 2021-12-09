require 'refinements/camelize'
require 'smart_properties'

module Fireblocks
  class Type
    using Fireblocks::Refinements::Camelize
    include SmartProperties
  end
end
