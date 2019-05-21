# frozen_string_literal: true

module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def destroy_volume(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "volume id is a required parameter for destroy-volume" unless options.key? :id

            client.destroy_volume(id, options[:id])
          end
        end

        class Mock
          def destroy_volume(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "volume id is a required parameter for destroy-volume" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
