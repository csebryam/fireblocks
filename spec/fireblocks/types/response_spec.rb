describe ::Fireblocks::Types::Response do
  class FunkyType < ::Fireblocks::Types::Response
    property :camelized_name
  end

  context "when deserializing" do
    expect(FunkyType.new(camelizedName: 'a value').camelized_name).to eq('a value')
  end
end
