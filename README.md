# Fireblocks

The Ruby gem wrapper for Fireblocks! This gem is actively being developed. **Be sure to check the branch for the version you're using.**

## Installation

To install, type:

```
gem install fireblocks
```

Add to your `Gemfile`:

```ruby
gem "fireblocks", "~> 0.1.0"
```

Run `bundle install`

## Configure

API keys *must* be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
Fireblocks.configure do |config|
  config.api_key = 'api_key'
  config.private_key = 'private_key'
  config.base_url = 'url'
end
```

`config.base_url` - the default is set to `'https://api.fireblocks.io'`

## Usage

* Full API documentation for this gem go to [API reference](https://api.fireblocks.io/docs/v1/swagger-ui/).
* Fireblocks official SDKs can be found [here](https://github.com/fireblocks)

Available methods can be found in `Fireblocks::API`

```
# To create a vault account
Fireblocks::API.create_vault_account(name: 'test_name')

# To get all vault accounts
Fireblocks::API.get_vault_accounts
```

## Contributing

Bug reports and pull requests are welcome.

* Please be sure to include tests with your PRs.
* Run `bundle exec rubocop` to ensure style with the rest of the project
