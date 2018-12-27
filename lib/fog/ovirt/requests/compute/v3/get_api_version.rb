module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def api_version
            client.api_version
          end
        end
        class Mock
          def api_version
            "3.1"
          end
        end
      end
    end
  end
end
