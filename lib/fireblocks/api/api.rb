# frozen_string_literal: true

module Fireblocks
  # Namespace to access Fireblocks api methods
  class API
    class << self
      def get_vault_accounts
        Request.get(path: '/v1/vault/accounts_paged')
      end

      def create_vault_account(name:)
        Request.post(body: { name: name }, path: '/v1/vault/accounts')
      end

      def get_vault_account(id)
        Request.get(path: "/v1/vault/accounts/#{id}")
      end

      def update_vault_account(vault_account_id, name:)
        Request.put(
          body: { name: name },
          path: "/v1/vault/accounts/#{vault_account_id}"
        )
      end

      def get_public_key_info_for_vault_account(vault_account_id, asset_id, change: 0, address_index: 0, compressed: true)
        Request.get(
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}/0/0/public_key_info?compressed=#{compressed}"
        )
      end

      def get_vault_account_asset(vault_account_id, asset_id)
        Request.get(path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}")
      end

      def create_vault_account_asset(vault_account_id, asset_id)
        Request.post(path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}")
      end

      def create_deposit_address(vault_account_id, asset_id, description: nil)
        Request.post(
          body: { description: description },
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}/addresses"
        )
      end

      def get_deposit_addresses(vault_account_id, asset_id)
        Request.get(
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}/addresses"
        )
      end

      def get_internal_wallet(wallet_id)
        Request.get(path: "/v1/internal_wallets/#{wallet_id}")
      end

      def get_internal_wallets
        Request.get(path: '/v1/internal_wallets')
      end

      def create_internal_wallet(name:)
        Request.post(body: { name: name }, path: '/v1/internal_wallets')
      end

      def get_supported_assets
        Request.get(path: '/v1/supported_assets')
      end
    end
  end
end
