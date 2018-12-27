module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_virtual_machines(filters = {})
            filters = filters.dup
            page = filters.delete(:page)
            without_details = filters.delete(:without_details)
            filters[:all_content] = true unless without_details
            filters[:search] = create_search_by_datacenter(:search => filters[:search], :datacenter => datacenter_hash[:name], :page => page)
            client.system_service.vms_service.list(filters).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_virtual_machines(_filters = {})
            xml = read_xml "vms.xml"
            Nokogiri::XML(xml).xpath("/vms/vm").map do |vm|
              ovirt_attrs OvirtSDK4::Reader.read(vm.to_s)
            end
          end
        end
      end
    end
  end
end
