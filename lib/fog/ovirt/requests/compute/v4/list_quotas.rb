module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_quotas(filters = {})
            data_center = client.system_service.data_centers_service.data_center_service(datacenter)
            data_center.quotas_service.list(filters).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_quotas(_filters = {})
            xml = read_xml "quotas.xml"
            Nokogiri::XML(xml).xpath("/quotas/quota").map do |q|
              ovirt_attrs OvirtSDK4::Reader.read(q.to_s)
            end
          end
        end
      end
    end
  end
end
