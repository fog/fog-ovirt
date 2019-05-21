module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def vm_start_with_cloudinit(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            client.vm_start_with_cloudinit(options[:id], options[:user_data])
          end
        end

        class Mock
          def vm_start_with_cloudinit(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
