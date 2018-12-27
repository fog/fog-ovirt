module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          # rubocop:disable Metrics/AbcSize
          def list_template_volumes(template_id)
            template = client.system_service.templates_service.template_service(template_id).get
            attachments = client.follow_link(template.disk_attachments)
            attachments.map do |attachment|
              attachment_disk = client.follow_link(attachment.disk)
              attachment = client.follow_link(attachment)
              bootable = attachment.bootable
              interface = attachment.interface
              attachment_disk.bootable = bootable if attachment_disk.bootable.nil?
              attachment_disk.interface = interface if attachment_disk.interface.nil?
              attachment_disk.storage_domain = attachment_disk.storage_domains[0].id if attachment_disk.storage_domains[0].present?
              ovirt_attrs attachment_disk
            end
          end
          # rubocop:enable Metrics/AbcSize
        end
        class Mock
          def list_template_volumes(_template_id)
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
