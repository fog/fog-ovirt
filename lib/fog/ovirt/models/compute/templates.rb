require "fog/core/collection"
require "fog/ovirt/models/compute/template"

module Fog
  module Ovirt
    class Compute
      class Templates < Fog::Collection
        model Fog::Ovirt::Compute::Template

        def all(filters = {})
          load service.list_templates(filters)
        end

        def get(id)
          new service.get_template(id)
        end
      end
    end
  end
end
