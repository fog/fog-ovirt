# frozen_string_literal: true

require "fog/core/collection"
require "fog/ovirt/models/compute/volume"

module Fog
  module Ovirt
    class Compute
      class Volumes < Fog::Collection
        model Fog::Ovirt::Compute::Volume

        attr_accessor :vm

        # rubocop:disable Metrics/AbcSize
        def all(_filters = {})
          if vm.is_a? Fog::Ovirt::Compute::Server
            load service.list_vm_volumes(vm.id)
          elsif vm.is_a? Fog::Ovirt::Compute::Template
            load service.list_template_volumes(vm.id)
          else
            load service.list_volumes
          end
        end
        # rubocop:enable Metrics/AbcSize

        def get(id)
          new service.get_volume(id)
        end
      end
    end
  end
end
