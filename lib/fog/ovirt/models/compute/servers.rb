# frozen_string_literal: true

require "fog/core/collection"
require "fog/ovirt/models/compute/server"

module Fog
  module Ovirt
    class Compute
      class Servers < Fog::Collection
        model Fog::Ovirt::Compute::Server

        def all(filters = {})
          load service.list_virtual_machines(filters)
        end

        def get(id)
          new service.get_virtual_machine(id)
        end

        def bootstrap(new_attributes = {})
          server = create(new_attributes)
          server.wait_for { stopped? }
          server.start
          server
        end
      end
    end
  end
end
