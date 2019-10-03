Shindo.tests("Fog::Ovirt::Compute.new | instance_type model", ["ovirt"]) do
  instance_types = Fog::Ovirt::Compute.new.instance_types
  instance_type = instance_types.last

  tests("The instance_type model should") do
    tests("have attributes") do
      model_attribute_hash = instance_type.attributes
      attributes = %i[id name memory sockets cores]

      tests("The instance type model should respond to") do
        attributes.each do |attribute|
          test(attribute.to_s) { instance_type.respond_to? attribute }
        end
      end
      tests("The attributes hash should have key") do
        attributes.each do |attribute|
          test(attribute.to_s) { model_attribute_hash.key? attribute }
        end
      end
    end
    test("be a kind of Fog::Ovirt::Compute::InstanceType") { instance_type.is_a? Fog::Ovirt::Compute::InstanceType }
  end
end
