describe ::Fireblocks::Type do
  class FunkyType < ::Fireblocks::Type
    property :camelized_name
  end


  context "when serializing" do
    expect(FunkyType.new(camelizedName: 'a value').camelized_name).to eq('a value')
  end

  context "when deserializing" do
  end
end
