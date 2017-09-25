require 'fog/core/collection'
require 'fog/ovirt/models/compute/operating_system'

module Fog
  module Compute
    class Ovirt
      class OperatingSystems < Fog::Collection
        model Fog::Compute::Ovirt::OperatingSystem

        def all
          load service.list_operating_systems
        end
     end
    end
  end
end
