module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          # rubocop:disable Metrics/AbcSize
          def update_vm(attrs)
            attrs = attrs.dup
            attrs = convert_string_to_bool(attrs)
            vm_service = client.system_service.vms_service.vm_service(attrs[:id])

            if attrs[:cores].present?
              cpu_topology = OvirtSDK4::CpuTopology.new(:cores => attrs[:cores], :sockets => "1")
              attrs[:cpu] = OvirtSDK4::Cpu.new(:topology => cpu_topology)
            end
            wrap_attribute(attrs, :cluster, OvirtSDK4::Cluster)
            attrs[:template] = if attrs[:template].present?
                                 OvirtSDK4::Template.new(:id => attrs[:template])
                               else
                                 blank_template
                               end

            wrap_attribute(attrs, :large_icon, OvirtSDK4::Icon)
            wrap_attribute(attrs, :small_icon, OvirtSDK4::Icon)
            wrap_attribute(attrs, :cpu_profile, OvirtSDK4::CpuProfile)
            wrap_attribute(attrs, :host, OvirtSDK4::Host)
            wrap_attribute(attrs, :quota, OvirtSDK4::Quota)
            wrap_attribute(attrs, :instance_type, OvirtSDK4::InstanceType)
            attrs[:high_availability] = OvirtSDK4::HighAvailability.new(:enabled => attrs[:ha] == "1") if attrs[:ha].present?
            attrs[:original_template] = if attrs[:original_template].present?
                                          OvirtSDK4::Template.new(:id => attrs[:original_template])
                                        else
                                          blank_template
                                        end
            vm_service.update(attrs)
          end
          # rubocop:enable Metrics/AbcSize

          def wrap_attribute(attrs, attribute, klass)
            if attrs[attribute].present?
              attrs[attribute] = klass.new(:id => attrs[attribute])
            else
              attrs.delete(attribute)
            end
          end
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
