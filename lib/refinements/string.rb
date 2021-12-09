module Fireblocks
  module Refinements
    module String
      refine String do
        def camelize
          split("_").map(&:capitalize).join
        end

        def snakecase
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .downcase
        end
      end
    end
  end
end
