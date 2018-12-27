module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def destroy_affinity_group(id)
            raise ArgumentError, "instance id is a required parameter" unless id
            client.destroy_affinity_group(id)
          end
        end

        class Mock
          def destroy_affinity_group(id)
            raise ArgumentError, "instance id is a required parameter" unless id
            true
          end
        end
      end
    end
  end
end
