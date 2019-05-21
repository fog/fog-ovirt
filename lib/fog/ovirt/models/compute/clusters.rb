require "fog/core/collection"
require "fog/ovirt/models/compute/cluster"

module Fog
  module Ovirt
    class Compute
      class Clusters < Fog::Collection
        model Fog::Ovirt::Compute::Cluster

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
