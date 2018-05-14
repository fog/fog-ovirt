module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def add_volume(id, options = {})
            raise ArgumentError, "instance id is a required parameter" unless id

            options = add_options_defaults(options)

            disk_attachments_service = client.system_service.vms_service.vm_service(id).disk_attachments_service
            disk = OvirtSDK4::DiskAttachment.new(options)
            disk_attachments_service.add(disk)
          end

          # rubocop:disable Metrics/AbcSize
          def add_options_defaults(options)
            options = options.dup
            search = options[:search] || format("datacenter=%<datacenter>s", :datacenter => datacenter)
            options[:bootable] = options.delete(:bootable) == "true"
            options[:interface] ||= OvirtSDK4::DiskInterface::VIRTIO
            options[:provisioned_size] = options[:size_gb].to_i * Fog::Compute::Ovirt::DISK_SIZE_TO_GB if options[:size_gb]

            options[:storage_domain_id] = options[:storage_domain] || storagedomains(:role => "data", :search => search).first.id
            # If no size is given, default to a volume size of 8GB
            options[:provisioned_size] ||= 8 * Fog::Compute::Ovirt::DISK_SIZE_TO_GB
            options[:type] ||= OvirtSDK4::DiskType::DATA
            options[:format] ||= OvirtSDK4::DiskFormat::COW
            options[:sparse] = true unless options[:sparse].present?
            options[:quota] = options[:quota].present? ? client.system_service.data_centers_service.data_center_service(datacenter).quotas_service.quota_service(options[:quota]).get : nil

            options[:disk] ||= {}
            options[:disk][:storage_domains] ||= [client.system_service.storage_domains_service.storage_domain_service(options[:storage_domain_id]).get]
            options[:disk][:provisioned_size] ||= options.delete(:provisioned_size)
            options[:disk][:format] ||= options.delete(:format)
            options[:disk][:sparse] ||= options.delete(:sparse) == "true"
            options[:disk][:wipe_after_delete] ||= options.delete(:wipe_after_delete) == "true"
            options
          end
          # rubocop:enable Metrics/AbcSize
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
