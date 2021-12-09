describe ::Fireblocks::Types::Request do
  class SimpleRequest < ::Fireblocks::Types::Request
    property :single
    property :double_word
  end

  context "when serializing" do
    subject { SimpleRequest.new(single: 'value', double_word: 'two words').to_h }

    it "should camelize keys" do
      binding.pry
      expect(subject).to match(a_hash_including(doubleWord: 'two words'))
    end
  end
end
