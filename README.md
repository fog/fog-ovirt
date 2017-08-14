# Fog::Ovirt

fog-ovirt is an ovirt provider for [fog](https://github.com/fog/fog).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fog-ovirt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog-ovirt

## Usage

Require the gem:
```ruby
require 'fog/ovirt' 
```

Connect to ovirt instance:
```ruby

compute = Fog::Compute.new(
          :provider         => "ovirt",
          :ovirt_username   => user,
          :ovirt_password   => password,
          :ovirt_url        => url,
          :ovirt_datacenter => uuid,
          :ovirt_ca_cert_store => ca_cert_store
      )
```

## Contributing

Please refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Please refer to [LICENSE.md](LICENSE.md).