module Fog
  module Compute
    class Ovirt
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
