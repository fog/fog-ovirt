module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def list_vm_volumes(vm_id)
            client.vm_volumes(vm_id).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_vm_volumes(_vm_id)
            xml = read_xml "volumes.xml"
            Nokogiri::XML(xml).xpath("/disks/disk").map do |vol|
              ovirt_attrs OVIRT::Volume.new(self, vol)
            end
          end
        end
      end
    end
  end
end
