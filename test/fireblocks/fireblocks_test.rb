# frozen_string_literal: true

require 'test_helper'

class FireblocksAPI < Minitest::Test
  describe Fireblocks::API do
    describe 'send GET Fireblocks requests' do
      let(:vault_name) { 'test_vault' }

      before do
        Fireblocks.reset
        Fireblocks.configure do |config|
          config.api_key = ENV['FIREBLOCKS_API_KEY']
          config.private_key = ENV['FIREBLOCKS_PRIVATE_KEY']
        end
      end

      def test_create_vault_account
        vault_account = Fireblocks::API.create_vault_account(name: vault_name)
        assert_equal vault_account['name'], vault_name
      end

      def test_get_vault_accounts
        Fireblocks::API.create_vault_account(name: vault_name)
        # Difficulty with parallel requests, add a sleep
        sleep(2)
        vault_accounts = Fireblocks::API.get_vault_accounts
        refute_empty vault_accounts
      end
    end
  end
end
