module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          def update_vm(attrs)
            attrs = attrs.dup
            vm_service = client.system_service.vms_service.vm_service(attrs[:id])

            if attrs[:cores].present?
              cpu_topology = OvirtSDK4::CpuTopology.new(:cores => attrs[:cores], :sockets => "1")
              attrs[:cpu] = OvirtSDK4::Cpu.new(:topology => cpu_topology)
            end
            attrs[:cluster] = attrs[:cluster].present? ? client.system_service.clusters_service.cluster_service(attrs[:cluster]).get : nil
            attrs[:template] = if attrs[:template].present?
                                 client.system_service.templates_service.template_service(attrs[:template]).get
                               else
                                 client.system_service.get.special_objects.blank_template
                               end

            attrs[:large_icon] = OvirtSDK4::Icon.new(:id => attrs[:large_icon])
            attrs[:small_icon] = OvirtSDK4::Icon.new(:id => attrs[:small_icon])
            attrs[:cpu_profile] = client.system_service.cpu_profiles_service.profile_service(attrs[:cpu_profile]).get
            attrs[:host] = client.system_service.hosts_service.host_service(attrs[:host]).get
            attrs[:original_template] = if attrs[:original_template].present?
                                          client.system_service.templates_service.template_service(attrs[:original_template]).get
                                        else
                                          client.system_service.get.special_objects.blank_template
                                        end
            vm_service.update(attrs)
          end
          # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
        end

        class Mock
          def update_vm(_attrs)
            xml = read_xml("vm.xml")
            OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
