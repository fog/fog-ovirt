module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def list_quotas(filters = {})
            client.quotas(filters).map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_quotas(_filters = {})
            xml = read_xml "quotas.xml"
            Nokogiri::XML(xml).xpath("/quotas/quota").map do |q|
              ovirt_attrs OVIRT::Quota.new(self, q)
            end
          end
        end
      end
    end
  end
end
