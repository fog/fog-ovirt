module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def create_disk_attachment_from_disk(disk_to_attachment)
            storage_domain = client.system_service.storage_domains_service.storage_domain_service(disk_to_attachment["storage_domain"]).get

            disk = {
              :id => disk_to_attachment["id"],
              :format => disk_to_attachment.fetch("format", OvirtSDK4::DiskFormat::COW),
              :sparse => disk_to_attachment.fetch("sparse", true),
              :storage_domains => [storage_domain]
            }

            OvirtSDK4::DiskAttachment.new(:disk => disk)
          end

          def process_vm_disks(opts)
            opts[:disk_attachments] = opts[:disks].map { |disk| create_disk_attachment_from_disk(disk) }
            opts.delete(:disks)
          end

          # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
          def create_vm(attrs)
            attrs = attrs.dup
            attrs = convert_string_to_bool(attrs)

            if attrs[:cluster].present?
              attrs[:cluster] = client.system_service.clusters_service.cluster_service(attrs[:cluster]).get
            else
              if attrs[:cluster_name].present?
                cluster = client.system_service.clusters_service.list(:search => "name=#{attrs[:cluster_name]}").first
              else
                cluster = client.system_service.clusters_service.list(:search => "datacenter=#{datacenter_hash[:name]}").first
                attrs[:cluster_name] = cluster.name
              end

              attrs[:cluster] = cluster
            end

            vms_service = client.system_service.vms_service

            attrs[:type] = attrs.fetch(:type, OvirtSDK4::VmType::SERVER)
            attrs[:instance_type] = attrs[:instance_type].present? ? client.system_service.instance_types_service.instance_type_service(attrs[:instance_type]).get : nil

            if attrs[:template].present?
              attrs[:template] = client.system_service.templates_service.template_service(attrs[:template]).get
            else
              attrs[:template] = client.system_service.get.special_objects.blank_template
              update_os_attrs(attrs)
            end

            attrs[:comment] ||= ""
            attrs[:quota] = attrs[:quota].present? ? client.system_service.data_centers_service.data_center_service(datacenter).quotas_service.quota_service(attrs[:quota]).get : nil
            if attrs[:cores].present? || attrs[:sockets].present?
              cpu_topology = OvirtSDK4::CpuTopology.new(:cores => attrs.fetch(:cores, "1"), :sockets => attrs.fetch(:sockets, "1"))
              attrs[:cpu] = OvirtSDK4::Cpu.new(:topology => cpu_topology)
            end
            attrs[:memory_policy] = OvirtSDK4::MemoryPolicy.new(:guaranteed => attrs[:memory]) if attrs[:memory].to_i < Fog::Ovirt::Compute::DISK_SIZE_TO_GB
            attrs[:high_availability] = OvirtSDK4::HighAvailability.new(:enabled => attrs[:ha] == "1") if attrs[:ha].present?

            process_vm_disks(attrs) if attrs[:clone] == true && attrs[:disks].present?

            new_vm = OvirtSDK4::Vm.new(attrs)
            vms_service.add(new_vm, :clone => attrs[:clone])
          end
          # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

          def update_os_attrs(attrs)
            attrs[:os] ||= {}
            attrs[:os][:type] ||= "Other OS"
            attrs[:os][:boot] ||= [attrs.fetch(:boot_dev1, OvirtSDK4::BootDevice::NETWORK), attrs.fetch(:boot_dev2, OvirtSDK4::BootDevice::HD)]
            attrs[:os][:boot] = attrs[:os][:boot].without(attrs["first_boot_dev"]).prepend(attrs["first_boot_dev"]) if attrs["first_boot_dev"]

            attrs[:os] = OvirtSDK4::OperatingSystem.new(:type => attrs[:os][:type], :boot => OvirtSDK4::Boot.new(:devices => attrs[:os][:boot]))
          end
        end

        class Mock
          def create_vm(_attrs)
            xml = read_xml("vm.xml")
            OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
