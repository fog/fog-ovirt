module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def list_virtual_machines(filters = {})
            client.vms(filters).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_virtual_machines(_filters = {})
            xml = read_xml "vms.xml"
            Nokogiri::XML(xml).xpath("/vms/vm").map do |vm|
              ovirt_attrs OVIRT::VM.new(self, vm)
            end
          end
        end
      end
    end
  end
end
