module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def add_interface(id, options = {})
            raise ArgumentError, "instance id is a required parameter" unless id
            vm = client.system_service.vms_service.vm_service(id)
            nics_service = vm.nics_service
            options = options.dup
            options = convert_string_to_bool(options)
            if options[:network].present? && options[:vnic_profile].nil?
              network = client.system_service.networks_service.network_service(options[:network]).get
              profiles = client.follow_link(network.vnic_profiles)
              profile = profiles.detect { |x| x.name == network.name }
              profile ||= profiles.min_by(&:name)
              options[:vnic_profile] = profile.id
            end
            options[:vnic_profile] = { :id => options[:vnic_profile] }
            options.delete(:network)
            interface = OvirtSDK4::Nic.new(options)
            nics_service.add(interface)
          end
        end

        class Mock
          def add_interface(id, _options = {})
            raise ArgumentError, "instance id is a required parameter" unless id
            true
          end
        end
      end
    end
  end
end
