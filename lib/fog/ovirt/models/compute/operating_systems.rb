require "fog/core/collection"
require "fog/ovirt/models/compute/operating_system"

module Fog
  module Ovirt
    class Compute
      class OperatingSystems < Fog::Collection
        model Fog::Ovirt::Compute::OperatingSystem

        def all
          load service.list_operating_systems
        end
      end
    end
  end
end
