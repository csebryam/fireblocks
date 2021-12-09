# assetId	string	The ID of the asset
# address	string	Address of the asset in a Vault Account, for BTC/LTC the address is in Segwit (Bech32) format, for BCH cash format
# legacyAddress	string	For BTC/LTC/BCH the legacy format address
# description	string	Description of the address
# tag	string	Destination tag for XRP, used as memo for EOS/XLM, for Signet/SEN it is the Bank Transfer Description
# type	string	Address type
# customerRefId	string	[optional] The ID for AML providers to associate the owner of funds with transactions
# bip44AddressIndex	number	The address_index in the derivation path of this address based on BIP44

module Fireblocks
  module Types
    module Vault
      class VaultAccountAssetAddress < Type
        property :asset_id
        property :address
        property :legacy_address
        property :description
        property :tag
        property :type
        property :customer_ref_id
        property :bip44_address_index
      end
    end
  end
end
