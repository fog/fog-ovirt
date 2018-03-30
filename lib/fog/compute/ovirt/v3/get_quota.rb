module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def get_quota(id)
            ovirt_attrs client.quota(id)
          end
        end
        class Mock
          def get_quota(_id)
            xml = read_xml("quota.xml")
            ovirt_attrs OVIRT::Quota.new(self, Nokogiri::XML(xml).root)
          end
        end
      end
    end
  end
end
