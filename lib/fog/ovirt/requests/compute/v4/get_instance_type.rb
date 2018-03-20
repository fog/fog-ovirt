module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def get_instance_type(id)
            ovirt_attrs client.system_service.instance_types_service.instance_type_service(id).get
          end
        end
        class Mock
          def get_instance_type(_id)
            xml = read_xml "instance_type.xml"
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
