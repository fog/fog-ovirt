module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def list_template_interfaces(vm_id)
            client.template_interfaces(vm_id).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_template_interfaces(_vm_id)
            xml = read_xml "nics.xml"
            Nokogiri::XML(xml).xpath("/nics/nic").map do |nic|
              ovirt_attrs OVIRT::Interface.new(self, nic)
            end
          end
        end
      end
    end
  end
end
