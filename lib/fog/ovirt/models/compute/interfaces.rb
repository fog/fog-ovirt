require "fog/core/collection"
require "fog/ovirt/models/compute/interface"

module Fog
  module Ovirt
    class Compute
      class Interfaces < Fog::Collection
        model Fog::Ovirt::Compute::Interface

        attr_accessor :vm

        def all(_filters = {})
          requires :vm
          case vm
          when Fog::Ovirt::Compute::Server
            load service.list_vm_interfaces(vm.id)
          when Fog::Ovirt::Compute::Template
            load service.list_template_interfaces(vm.id)
          else
            raise ::Fog::Ovirt::Errors::OvirtError, "interfaces should have vm or template"
          end
        end

        def get(id)
          new service.get_interface(id)
        end
      end
    end
  end
end
