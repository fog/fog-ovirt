module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def destroy_vm(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id

            client.system_service.vms_service.vm_service(options[:id]).remove
            true
          end
        end

        class Mock
          def destroy_vm(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
