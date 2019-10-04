# frozen_string_literal: true

require 'test_helper'

class FireblocksConfiguration < Minitest::Test
  describe Fireblocks::Configuration do
    let(:new_base_url) { 'example.com' }

    describe 'with configuration block' do
      before do
        Fireblocks.configure do |config|
          config.api_key = ENV['FIREBLOCKS_API_KEY']
          config.private_key = ENV['FIREBLOCKS_PRIVATE_KEY']
        end
      end

      def test_it_returns_api_key
        assert_equal Fireblocks.configuration.api_key, ENV['FIREBLOCKS_API_KEY']
      end

      def test_it_returns_private_key
        assert_equal(
          Fireblocks.configuration.private_key, ENV['FIREBLOCKS_PRIVATE_KEY']
        )
      end

      def test_it_resassigns_base_url
        Fireblocks.configure { |config| config.base_url = new_base_url }
        assert_equal Fireblocks.configuration.base_url, new_base_url
      end
    end

    describe 'without configuration keys' do
      before do
        Fireblocks.reset
      end

      def test_it_raises_api_key_error
        assert_raises(Fireblocks::Configuration::Error) do
          Fireblocks.configuration.api_key
        end
      end

      def test_it_raises_private_key_error
        assert_raises(Fireblocks::Configuration::Error) do
          Fireblocks.configuration.private_key
        end
      end
    end
  end
end
