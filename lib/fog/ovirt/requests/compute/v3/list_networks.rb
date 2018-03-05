module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def list_networks(cluster_id)
            client.networks(:cluster_id => cluster_id)
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
