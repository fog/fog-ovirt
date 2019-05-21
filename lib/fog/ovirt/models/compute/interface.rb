# frozen_string_literal: true

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

        def to_s
          name
        end
      end
    end
  end
end
