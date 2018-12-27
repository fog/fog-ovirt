module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_templates(filters = {})
            client.system_service.templates_service.list(filters).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_templates(_filters = {})
            xml = read_xml "templates.xml"
            Nokogiri::XML(xml).xpath("/templates/template").map do |t|
              ovirt_attrs OvirtSDK4::Reader.read(t.to_s)
            end
          end
        end
      end
    end
  end
end
