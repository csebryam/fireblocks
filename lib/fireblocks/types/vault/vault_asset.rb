# Parameter	Type	Description
# id	string	The ID of the asset
# total	string	The total wallet balance.
# balance	string	Deprecated - replaced by "total"
# available	string	Funds available for transfer. Equals the blockchain balance minus any locked amount
# pending	string	The cumulative balance of all transactions pending to be cleared
# staked	string	Staked funds, returned only for DOT
# frozen	string	Frozen by the AML policy in your workspace
# lockedAmount	string	Funds in outgoing transactions that are not yet published to the network
# totalStakedCPU	string	[optional] Deprecated
# totalStakedNetwork	string	[optional] Deprecated
# selfStakedCPU	string	[optional] Deprecated
# selfStakedNetwork	string	[optional] Deprecated
# pendingRefundCPU	string	[optional] Deprecated
# pendingRefundNetwork	string	[optional] Deprecated
# blockHeight	string	The height (number) of the block of the balance
# blockHash	string	The hash of the block of the balance


module Fireblocks
  module Types
    module Vault
      class VaultAsset < Type
        property! :id
        property! :total
        property :available
        property :pending
        property :staked
        property :frozen
        property :locked_amount
        property :block_height
        property :block_hash
      end
    end
  end
end
