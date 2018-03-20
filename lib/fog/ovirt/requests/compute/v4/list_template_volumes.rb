module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def list_template_volumes(template_id)
            template = client.system_service.templates_service.template_service(template_id).get

            attachments = client.follow_link(template.disk_attachments)

            attachments.map do |attachment|
              ovirt_attrs client.follow_link(attachment.disk)
            end
          end
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
