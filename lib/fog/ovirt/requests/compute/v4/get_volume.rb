module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def get_volume(id)
            ovirt_attrs client.system_service.disks_service.disk_service(id).get
          end
        end
        class Mock
          def get_volume(_id)
            xml = read_xml("disk.xml")
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
