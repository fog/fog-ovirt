# frozen_string_literal: true

module Fog
  module Ovirt
    class Compute
      class Quota < Fog::Model
        identity :id

        attribute :name
        attribute :description

        def to_s
          name
        end
      end
    end
  end
end
