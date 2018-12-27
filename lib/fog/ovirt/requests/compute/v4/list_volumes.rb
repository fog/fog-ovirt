module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_volumes
            client.system_service.disks_service.list.map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_volumes
            xml = read_xml "disks.xml"
            Nokogiri::XML(xml).xpath("/disks/disk").map do |vol|
              ovirt_attrs OvirtSDK4::Reader.read(vol.to_s)
            end
          end
        end
      end
    end
  end
end
