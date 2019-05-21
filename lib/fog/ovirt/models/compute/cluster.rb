module Fog
  module Ovirt
    class Compute
      class Cluster < Fog::Model
        identity :id

        attribute :name
        attribute :raw

        def networks
          service.list_networks(id)
        end

        def to_s
          name
        end
      end
    end
  end
end
