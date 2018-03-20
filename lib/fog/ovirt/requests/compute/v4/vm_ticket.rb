module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def vm_ticket(id, options = {})
            client.system_service.vms_service.vm_service(id).ticket(options)
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
