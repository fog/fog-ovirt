module Fog
  module Compute
    class Ovirt
      class V3
        class Real
          def list_operating_systems
            client.operating_systems.map { |ovirt_obj| ovirt_attrs ovirt_obj }
          end
        end
        class Mock
          def list_operating_systems
            xml = read_xml "operating_systems.xml"
            Nokogiri::XML(xml).xpath("/operating_systems/operating_system").map do |os|
              ovirt_attrs OVIRT::OperatingSystem.new(self, os)
            end
          end
        end
      end
    end
  end
end
