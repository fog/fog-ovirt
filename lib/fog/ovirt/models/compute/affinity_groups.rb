require "fog/core/collection"
require "fog/ovirt/models/compute/affinity_group"

module Fog
  module Ovirt
    class Compute
      class AffinityGroups < Fog::Collection
        model Fog::Ovirt::Compute::AffinityGroup

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
