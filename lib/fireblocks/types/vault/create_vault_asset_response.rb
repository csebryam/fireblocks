module Fireblocks
  module Types
    module Vault
      class CreateVaultAssetResponse < Response
        property :id
        property :address
        property :legacy_address
        property :tag
        property :eos_account_name
      end
    end
  end
end
