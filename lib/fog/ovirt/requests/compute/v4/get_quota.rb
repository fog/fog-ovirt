module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def get_quota(id)
            quota = client.system_service.data_centers_service.data_center_service(datacenter).quotas_service.quota_service(id).get
            ovirt_attrs quota
          end
        end
        class Mock
          def get_quota(_id)
            xml = read_xml("quota.xml")
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
