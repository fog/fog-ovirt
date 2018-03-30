require "fog/core/collection"
require "fog/compute/ovirt/models/affinity_group"

module Fog
  module Compute
    class Ovirt
      class AffinityGroups < Fog::Collection
        model Fog::Compute::Ovirt::AffinityGroup

        def all(filters = {})
          load service.list_affinity_groups(filters)
        end

        def get(id)
          new service.get_affinity_group(id)
        end
      end
    end
  end
end
