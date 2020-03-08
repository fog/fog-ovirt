module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def add_volume(id, options = {})
            raise ArgumentError, "instance id is a required parameter" unless id

            options = add_options_defaults(options)

            disk_attachments_service = client.system_service.vms_service.vm_service(id).disk_attachments_service
            disk = OvirtSDK4::DiskAttachment.new(options)
            disk_attachments_service.add(disk)
          end

          # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          def add_options_defaults(options)
            options = options.dup
            options = convert_string_to_bool(options)
            options[:bootable] = options.delete(:bootable)
            options[:interface] ||= OvirtSDK4::DiskInterface::VIRTIO
            options[:provisioned_size] = options[:size_gb].to_i * Fog::Ovirt::Compute::DISK_SIZE_TO_GB if options[:size_gb]
            options[:sparse] = true if options[:sparse].nil?
            options[:storage_domain_id] = options[:storage_domain] if options[:storage_domain]
            # If no size is given, default to a volume size of 8GB
            options[:provisioned_size] ||= 8 * Fog::Ovirt::Compute::DISK_SIZE_TO_GB
            options[:type] ||= OvirtSDK4::DiskType::DATA
            options[:format] ||= OvirtSDK4::DiskFormat::COW
            options[:quota] = options[:quota].present? ? client.system_service.data_centers_service.data_center_service(datacenter).quotas_service.quota_service(options[:quota]).get : nil
            options[:disk] ||= {}
            options[:disk][:sparse] = options.delete(:sparse) if options[:disk][:sparse].nil?
            options[:disk][:storage_domains] ||= [client.system_service.storage_domains_service.storage_domain_service(options[:storage_domain_id]).get] if options[:storage_domain_id]
            options[:disk][:provisioned_size] ||= options.delete(:provisioned_size)
            options[:disk][:format] ||= options.delete(:format)
            options[:disk][:wipe_after_delete] = options.delete(:wipe_after_delete) if options[:disk][:wipe_after_delete].nil?
            options
          end
          # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        end

        class Mock
          def add_volume(id, _options = {})
            raise ArgumentError, "instance id is a required parameter" unless id
            true
          end
        end
      end
    end
  end
end
