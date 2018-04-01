Shindo.tests("Fog::Compute[:ovirt] | operating_system model", ["ovirt"]) do
  operating_systems = Fog::Compute[:ovirt].operating_systems
  operating_system = operating_systems.last

  tests("The operating_system model should") do
    tests("have attributes") do
      model_attribute_hash = operating_system.attributes
      attributes = %i[id name href description]

      tests("The operating_system model should respond to") do
        attributes.each do |attribute|
          test(attribute.to_s) { operating_system.respond_to? attribute }
        end
      end
      tests("The attributes hash should have key") do
        attributes.each do |attribute|
          test(attribute.to_s) { model_attribute_hash.key? attribute }
        end
      end
    end
    test("be a kind of Fog::Compute::Ovirt::OperatingSystem") { operating_system.is_a? Fog::Compute::Ovirt::OperatingSystem }
  end
end
