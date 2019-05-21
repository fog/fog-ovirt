# frozen_string_literal: true

Shindo.tests("Fog::Ovirt::Compute.new | operating_system model", ["ovirt"]) do
  operating_systems = Fog::Ovirt::Compute.new.operating_systems
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
    test("be a kind of Fog::Ovirt::Compute::OperatingSystem") { operating_system.is_a? Fog::Ovirt::Compute::OperatingSystem }
  end
end
