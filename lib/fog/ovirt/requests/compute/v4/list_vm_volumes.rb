module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_vm_volumes(vm_id)
            vm = client.system_service.vms_service.vm_service(vm_id).get
            attachments = client.follow_link(vm.disk_attachments)
            attachments.map do |attachment|
              attachment_disk = client.follow_link(attachment.disk)
              attachment = client.follow_link(attachment)
              bootable = attachment.bootable
              interface = attachment.interface
              attachment_disk.bootable = bootable if attachment_disk.bootable.nil?
              attachment_disk.interface = interface if attachment_disk.interface.nil?
              attachment_disk.storage_domain = begin
                                                 attachment_disk.storage_domains[0].id || 0
                                               rescue => e
                                                 Fog::Logger.warning("Error parsing attachment_disk.storage_domains response json - #{e}. Fallback to 0")
                                                 0
                                               end
              ovirt_attrs attachment_disk
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
