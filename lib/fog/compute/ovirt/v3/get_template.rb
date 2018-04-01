module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def get_template(id)
            ovirt_attrs client.template(id)
          end
        end
        class Mock
          def get_template(_id)
            xml = read_xml "template.xml"
            ovirt_attrs OVIRT::Template.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
