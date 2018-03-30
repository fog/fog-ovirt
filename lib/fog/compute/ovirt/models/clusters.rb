require "fog/core/collection"
require "fog/compute/ovirt/models/cluster"

module Fog
  module Compute
    class Ovirt
      class Clusters < Fog::Collection
        model Fog::Compute::Ovirt::Cluster

        def all(filters = {})
          load service.list_clusters(filters)
        end

        def get(id)
          new service.get_cluster(id)
        end
      end
    end
  end
end
