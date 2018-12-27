module Fog
  module Ovirt
    class Compute
      class V3
        module Shared
          def check_arguments(id, options)
            raise ArgumentError, "instance id is a required parameter" unless id
            raise ArgumentError, "disk id is a required parameter for update-volume" unless options.key? :id
          end
        end

        class Real
          extend ::Fog::Ovirt::Compute::V3::Shared

          def update_volume(id, options)
            check_arguments(id, options)

            disk_id = options[:id]
            options.delete(:id)

            client.update_volume(id, disk_id, options)
            true # If we come here, expect success and return true
          end
        end

        class Mock
          extend ::Fog::Ovirt::Compute::V3::Shared

          def update_volume(id, options)
            check_arguments(id, options)
            true
          end
        end
      end
    end
  end
end
