require "fog/core/collection"
require "fog/ovirt/models/compute/quota"

module Fog
  module Ovirt
    class Compute
      class Quotas < Fog::Collection
        model Fog::Ovirt::Compute::Quota

        def all(filters = {})
          load service.list_quotas(filters)
        end

        def get(id)
          new service.get_quota(id)
        end
      end
    end
  end
end
