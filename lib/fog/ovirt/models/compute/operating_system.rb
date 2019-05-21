module Fog
  module Ovirt
    class Compute
      class OperatingSystem < Fog::Model
        attr_accessor :raw
        identity :id

        attribute :name
        attribute :href
        attribute :description

        def to_s
          name
        end
      end
    end
  end
end
