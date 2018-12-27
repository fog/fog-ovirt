module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_networks(cluster_id)
            client.system_service.clusters_service.cluster_service(cluster_id).networks_service.list
          end
        end
        class Mock
          def list_networks(_cluster_id)
            []
          end
        end
      end
    end
  end
end
