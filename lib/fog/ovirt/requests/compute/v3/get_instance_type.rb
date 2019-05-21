module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def get_instance_type(id)
            ovirt_attrs client.instance_type(id)
          end
        end
        class Mock
          def get_instance_type(_id)
            xml = read_xml "instance_type.xml"
            ovirt_attrs OVIRT::InstanceType.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
