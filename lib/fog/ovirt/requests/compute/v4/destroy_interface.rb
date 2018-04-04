module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def destroy_interface(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "interface id is a required parameter for destroy-interface" unless options.key? :id
            vm = client.system_service.vms_service.vm_service(id)
            vm.nics_service.nic_service(options[:id]).remove
          end
        end

        class Mock
          def destroy_interface(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "interface id is a required parameter for destroy-interface" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
