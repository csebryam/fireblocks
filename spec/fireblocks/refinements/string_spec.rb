RSpec.describe Fireblocks::Refinements::String do
  class RefinedStringClass
    using Fireblocks::Refinements::String

    def self.snake_to_camel
      "will_be_camel_case".camelize
    end

    def self.camel_to_snake
      "willBeSnakeCase".snakecase
    end
  end

  describe '.camelize' do
    expect(RefinedStringClass.snake_to_camel).to eq('willBeCamelCase')
  end

  describe '.snakecase' do
    expect(RefinedStringClass.camel_to_snake).to eq('will_be_snake_case')
  end
end
