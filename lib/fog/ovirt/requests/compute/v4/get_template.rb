module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def get_template(id)
            ovirt_attrs client.system_service.templates_service.template_service(id).get
          end
        end
        class Mock
          def get_template(_id)
            xml = read_xml "template.xml"
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
