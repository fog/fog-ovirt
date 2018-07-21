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

## API Support

This gem fully supports API v3 of oVirt.

Version 1.0.2 adds support API V4 as well.
The first version does not give full support.
The supported requests for API V4 are:

    :vm_action, :destroy_vm, :create_vm, :update_vm (without os changes)
    :datacenters
    :storage_domains
    :list_virtual_machines, :get_virtual_machine
    :list_templates, :get_template
    :list_instance_types, :get_instance_type
    :list_clusters, :get_cluster
    :add_interface, :destroy_interface, :update_interface, :list_vm_interfaces, :list_template_interfaces
    :list_networks
    :vm_ticket
    :list_vm_volumes, :list_template_volumes, :list_volumes, :add_volume, :destroy_volume, :update_volume
    :get_api_version
    :list_quotas, :get_quota
    :list_operating_systems
    
### Choosing api version

This example shows the usage as a fog provider:

    client = Fog::Compute.new(
        :provider         => "ovirt",
        :ovirt_username   => user,
        :ovirt_password   => password,
        :ovirt_url        => url,
        :ovirt_datacenter => datacenter,
        :public_key       => public_key,
        :api_version      => 'v4'
      )    
The :api_version can be sent 'v3' or 'v4' to determine which API version to use. 


Feedback is welcome. Please feel free to open issues for the V4 support and contribute.

## Contributing

Please refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Please refer to [LICENSE.md](LICENSE.md).