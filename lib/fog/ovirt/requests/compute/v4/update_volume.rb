module Fog
  module Compute
    class Ovirt
      class V4
        module Shared
          def check_arguments(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "disk id is a required parameter for update-volume" unless options.key? :id
          end
        end

        class Real
          extend ::Fog::Compute::Ovirt::V4::Shared

          def update_volume(id, options)
            check_arguments(id, options)

            disk_id = options[:id]
            disk_attachment = client.system_service.vms_service.vm_service(id).disk_attachments_service.attachment_service(disk_id)
            disk_attachment.update(disk_attachment, options)
            true # If we come here, expect success and return true
          end
        end

        class Mock
          extend ::Fog::Compute::Ovirt::V4::Shared

          def update_volume(id, options)
            check_arguments(id, options)
            true
          end
        end
      end
    end
  end
end
