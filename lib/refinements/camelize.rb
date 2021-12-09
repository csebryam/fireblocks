module Fireblocks
  module Refinements
    module Camelize
      refine String do
        def camelize
          split("_").map(&:capitalize).join
        end
      end
    end
  end
end
