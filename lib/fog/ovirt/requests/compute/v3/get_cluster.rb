module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def get_cluster(id)
            ovirt_attrs client.cluster(id)
          end
        end
        class Mock
          def get_cluster(_id)
            xml = read_xml("cluster.xml")
            ovirt_attrs OVIRT::Cluster.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
