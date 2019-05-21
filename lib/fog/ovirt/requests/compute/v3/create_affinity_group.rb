module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def create_affinity_group(attrs)
            client.create_affinity_group(attrs)
          end
        end

        class Mock
          def create_affinity_group(_attrs)
            xml = read_xml("affinitygroup.xml")
            OVIRT::AffinityGroup.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
