module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def list_vm_interfaces(vm_id)
            client.system_service.vms_service.vm_service(vm_id).nics_service.list.map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_vm_interfaces(_vm_id)
            xml = read_xml "nics.xml"
            Nokogiri::XML(xml).xpath("/nics/nic").map do |nic|
              ovirt_attrs OvirtSDK4::Reader.read(nic.to_s)
            end
          end
        end
      end
    end
  end
end
