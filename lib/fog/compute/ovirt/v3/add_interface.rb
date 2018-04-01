module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def add_interface(id, options = {})
            raise ArgumentError, "instance id is a required parameter" unless id

            client.add_interface(id, options)
          end
        end

        class Mock
          def add_interface(id, _options = {})
            raise ArgumentError, "instance id is a required parameter" unless id
            true
          end
        end
      end
    end
  end
end
