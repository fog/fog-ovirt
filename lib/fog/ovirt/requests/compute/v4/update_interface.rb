module Fog
  module Compute
    class Ovirt
      class V4
        module Shared
          def check_arguments(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "interface id is a required parameter for update-interface" unless options.key? :id
          end
        end

        class Real
          extend ::Fog::Compute::Ovirt::V4::Shared

          def update_interface(id, options)
            check_arguments(id, options)

            interface_id = options[:id]
            nic = client.system_service.vms_service.vm_service(id).nics_service.nic_service(interface_id)
            nic.update(nic, options)
          end
        end

        class Mock
          extend ::Fog::Compute::Ovirt::V4::Shared

          def update_interface(id, options)
            check_arguments(id, options)
            true
          end
        end
      end
    end
  end
end
