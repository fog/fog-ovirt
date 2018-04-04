module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def get_virtual_machine(id)
            ovirt_attrs client.system_service.vms_service.vm_service(id).get
          end
        end
        class Mock
          def get_virtual_machine(_id)
            xml = read_xml "vm.xml"
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
