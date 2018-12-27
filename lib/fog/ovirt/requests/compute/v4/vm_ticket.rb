module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def vm_ticket(id, options = {})
            options = convert_string_to_bool(options)
            client.system_service.vms_service.vm_service(id).ticket(options).value
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
