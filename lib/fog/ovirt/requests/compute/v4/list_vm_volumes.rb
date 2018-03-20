module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def list_vm_volumes(vm_id)
            # disk_attachments_service = client.system_service.vms_service.vm_service(vm_id).disk_attachments_service
            # disk_attachments_service.list.map {|ovirt_obj| ovirt_attrs client.system_service.disks_service.disk_service(ovirt_obj.id).get}

            vm = client.system_service.vms_service.vm_service(vm_id).get

            attachments = client.follow_link(vm.disk_attachments)

            attachments.map do |attachment|
              ovirt_attrs client.follow_link(attachment.disk)
            end
          end
        end
        class Mock
          def list_vm_volumes(_vm_id)
            xml = read_xml "volumes.xml"
            Nokogiri::XML(xml).xpath("/disks/disk").map do |vol|
              ovirt_attrs OvirtSDK4::Reader.read(vol.to_s)
            end
          end
        end
      end
    end
  end
end
