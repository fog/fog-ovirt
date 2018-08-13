module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def list_clusters(opts = {})
            opts[:search] = create_search_by_datacenter(:search => opts[:search], :datacenter => datacenter_hash[:name])
            client.system_service.clusters_service.list(opts).map { |ovirt_obj| ovirt_attrs(ovirt_obj) }
          end
        end
        class Mock
          def list_clusters(_filters = {})
            xml = read_xml "clusters.xml"
            Nokogiri::XML(xml).xpath("/clusters/cluster").map do |cl|
              ovirt_attrs OvirtSDK4::Reader.read(cl.to_s)
            end
          end
        end
      end
    end
  end
end
