module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def vm_action(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            raise ArgumentError, "action is a required parameter" unless options.key? :action

            vm_service = client.system_service.vms_service.vm_service(options[:id])
            vm_service.public_send(options[:action])
            vm_service.get.status
          end
        end

        class Mock
          def vm_action(options = {})
            raise ArgumentError, "id is a required parameter" unless options.key? :id
            raise ArgumentError, "action is a required parameter" unless options.key? :action
            true
          end
        end
      end
    end
  end
end
