require "fog/core/collection"
require "fog/compute/ovirt/models/instance_type"

module Fog
  module Compute
    class Ovirt
      class InstanceTypes < Fog::Collection
        model Fog::Compute::Ovirt::InstanceType

        def all(filters = {})
          load service.list_instance_types(filters)
        end

        def get(id)
          new service.get_instance_type(id)
        end
      end
    end
  end
end
