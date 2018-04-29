module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def vm_start_with_cloudinit(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id

            vm_service = client.system_service.vms_service.vm_service(options[:id])
            vm_service.start(:use_cloud_init => true, :vm => { :initialization => options[:user_data] })
          end
        end

        class Mock
          def vm_start_with_cloudinit(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
