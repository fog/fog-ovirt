module Fog
  module Ovirt
    class Compute
      class V3
        class Real
          def list_affinity_group_vms(id)
            client.affinity_group_vms(id).map { |vm| servers.get(vm.id) }
          end
        end

        class Mock
          def list_affinity_group_vms(_id)
            vms = []
            Nokogiri::XML(read_xml("affinitygroup_vms.xml")).xpath("/vms/vm/@id").each do |id|
              xml = Nokogiri::XML(read_xml("vms.xml")).xpath(format("/vms/vm[@id='%<id>s']", id.value)).first
              vms << ovirt_attrs(OVIRT::VM.new(self, xml))
            end
            vms
          end
        end
      end
    end
  end
end
