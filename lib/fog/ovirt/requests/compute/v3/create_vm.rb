module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def create_vm(attrs)
            client.create_vm(attrs)
          end
        end

        class Mock
          def create_vm(_attrs)
            xml = read_xml("vm.xml")
            OVIRT::VM.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
