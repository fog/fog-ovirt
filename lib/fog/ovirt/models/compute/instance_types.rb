require "fog/core/collection"
require "fog/ovirt/models/compute/instance_type"

module Fog
  module Ovirt
    class Compute
      class InstanceTypes < Fog::Collection
        model Fog::Ovirt::Compute::InstanceType

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
