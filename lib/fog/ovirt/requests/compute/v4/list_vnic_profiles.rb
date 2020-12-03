module Fog
  module Ovirt
    class Compute
      class V4
        class Real
          def list_vnic_profiles(_opts = {})
            dc_vnics = []
            profiles = client.system_service.vnic_profiles_service.list
            profiles.each do |profile|
              vnic_network = client.follow_link(profile.network)
              dc_vnics.append(profile) if vnic_network.data_center.id == datacenter
            end
            dc_vnics
          end
        end
        class Mock
          def list_vnic_profiles(_filters = {})
            xml = read_xml "vnic_profiles.xml"
            ovirt_attrs OvirtSDK4::Reader.read(Nokogiri::XML(xml).root.to_s)
          end
        end
      end
    end
  end
end
