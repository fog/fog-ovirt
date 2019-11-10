module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def get_volume(id)
            ovirt_attrs client.disk(id)
          end
        end
        class Mock
          def get_volume(_id)
            xml = read_xml("volume.xml")
            ovirt_attrs OVIRT::Volume.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
