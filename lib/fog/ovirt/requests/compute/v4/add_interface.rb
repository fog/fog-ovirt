module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          # rubocop:disable Metrics/AbcSize
          def add_interface(id, options = {})
            raise ArgumentError, "instance id is a required parameter" unless id
            vm = client.system_service.vms_service.vm_service(id)
            nics_service = vm.nics_service
            options = options.dup

            if options[:network].present?
              network = client.system_service.networks_service.network_service(options[:network]).get

              profiles = client.follow_link(network.vnic_profiles)

              profile = profiles.detect { |x| x.name == network.name }

              profile ||= profiles.min_by(&:name)

              options.delete(:network)
              options[:vnic_profile] = { :id => profile.id }
            end

            interface = OvirtSDK4::Nic.new(options)
            nics_service.add(interface)
          end
          # rubocop:enable Metrics/AbcSize
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
