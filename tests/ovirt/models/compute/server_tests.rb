# rubocop:disable Metrics/BlockLength
Shindo.tests("Fog::Ovirt::Compute.new | server model", ["ovirt"]) do
  servers = Fog::Ovirt::Compute.new.servers
  server = servers.last

  tests("The server model should") do
    tests("have the action") do
      test("reload") { server.respond_to? "reload" }
      %w[start stop destroy reboot suspend].each do |action|
        test(action) { server.respond_to? action }
      end
      %w[start reboot suspend stop].each do |action|
        test("#{action} returns successfully") do
          server.send(action.to_sym) ? true : false
        end
      end
    end
    tests("have attributes") do
      model_attribute_hash = server.attributes
      attributes = %i[
        id
        name
        description
        profile
        display
        creation_time
        os
        status
        cores
        memory
        cluster
        template
      ]
      tests("The server model should respond to") do
        attributes.each do |attribute|
          test(attribute.to_s) { server.respond_to? attribute }
        end
      end
      tests("The attributes hash should have key") do
        attributes.each do |attribute|
          test(attribute.to_s) { model_attribute_hash.key? attribute }
        end
      end
    end
    test("be a kind of Fog::Ovirt::Compute::Server") { server.is_a? Fog::Ovirt::Compute::Server }
  end
end
# rubocop:enable Metrics/BlockLength
