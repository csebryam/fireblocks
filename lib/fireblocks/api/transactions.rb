module Fireblocks
  class API
    class Transactions
      class << self
        VALID_TRANSACTION_KEYS = [
            :amount,
            :assetId,
            :source,
            :destination,
            :fee,
            :gasPrice,
            :note,
            :autoStaking,
            :networkStaking,
            :cpuStaking,
            :operation,
            :extraParameters
        ]

        def create(options, config = nil)
          body = options.slice(*VALID_TRANSACTION_KEYS)
          Fireblocks::Request.post(body: body, path: '/v1/transactions', config: config)
        end

        def get(id, config = nil)
          Request.get(path: "/v1/transactions/#{id}", config: config)
        end

        def from_vault_to_external(
          amount:,
          asset_id:,
          source_id:,
          destination_id:,
          one_time_address:,
          tag: nil
        )
          one_time_address_hash = {
            address: one_time_address
          }
          one_time_address_hash.merge(tag: tag) if tag

          body = {
            amount: amount,
            assetId: asset_id,
            source: {
              type: 'VAULT_ACCOUNT',
              id: source_id
            },
            destination: {
              type: 'EXTERNAL_WALLET',
              id: destination_id,
              oneTimeAddress: one_time_address_hash
            }
          }
          create(body)
        end
      end
    end
  end
end
