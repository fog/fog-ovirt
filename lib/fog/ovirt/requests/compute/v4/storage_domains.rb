module Fog
  module Compute
    class Ovirt
      class V4
        class Real
          def storage_domains(filter = {})
            filter = filter.dup
            role_filter = filter.delete(:role)
            client.system_service.storage_domains_service.list(filter).collect do |sd|
              # Filter by role is not supported by the search language. The work around is to list all, then filter.
              role_filter.nil? || sd.type == role_filter ? sd : nil
            end.compact
          end
        end

        class Mock
          def storage_domains(_filters = {})
            xml = read_xml "storage_domains.xml"
            Nokogiri::XML(xml).xpath("/storage_domains/storage_domain").map do |sd|
              OvirtSDK4::Reader.read(sd.to_s)
            end
          end
        end
      end
    end
  end
end
