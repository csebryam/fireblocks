describe ::Fireblocks::Types::Request do
  class FunkyType < ::Fireblocks::Types::Request
    property :camelized_name
  end

  context "when serializing" do
    it "should camelize keys" do
      binding.pry
      expect(FunkyType.new(camelized_name: 'a value').to_camel_keys).to eq('camelizedName' => 'a value')
    end
  end
end
