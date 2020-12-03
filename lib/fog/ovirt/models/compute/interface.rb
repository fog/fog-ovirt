module Fog
  module Ovirt
    class Compute
      class Interface < Fog::Model
        attr_accessor :raw
        identity :id

        attribute :name
        attribute :network
        attribute :interface
        attribute :mac
        attribute :vnic_profile

        def to_s
          name
        end
      end
    end
  end
end
