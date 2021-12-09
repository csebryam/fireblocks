describe ::Fireblocks::Types::Response do
  class Transaction < ::Fireblocks::Types::Response
    property :transaction_hash, accepts: :camelize
  end

  context "when deserializing" do
    expect(Transaction.new(transactionHash: 'a value').to_snake_hash).to match(a_hash_including(transaction_hash: 'a value'))
  end
end
