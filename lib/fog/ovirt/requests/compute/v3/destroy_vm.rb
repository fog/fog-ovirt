# frozen_string_literal: true

module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def destroy_vm(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            client.destroy_vm(options[:id])
          end
        end

        class Mock
          def destroy_vm(options = {})
            raise ArgumentError, "instance id is a required parameter" unless options.key? :id
            true
          end
        end
      end
    end
  end
end
