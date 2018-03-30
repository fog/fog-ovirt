module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def vm_ticket(id, options = {})
            client.set_ticket(id, options)
          end
        end

        class Mock
          def vm_ticket(_id, _options = {})
            "Secret"
          end
        end
      end
    end
  end
end
