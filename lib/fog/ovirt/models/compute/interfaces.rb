require "fog/core/collection"
require "fog/ovirt/models/compute/interface"

module Fog
  module Compute
    class Ovirt
      class Interfaces < Fog::Collection
        model Fog::Compute::Ovirt::Interface

        attr_accessor :vm

        # rubocop:disable Metrics/AbcSize
        def all(_filters = {})
          requires :vm
          if vm.is_a? Fog::Compute::Ovirt::Server
            load service.list_vm_interfaces(vm.id)
          elsif vm.is_a? Fog::Compute::Ovirt::Template
            load service.list_template_interfaces(vm.id)
          else
            raise ::Fog::Ovirt::Errors::OvirtError, "interfaces should have vm or template"
          end
        end
        # rubocop:enable Metrics/AbcSize

        def get(id)
          new service.get_interface(id)
        end
      end
    end
  end
end
