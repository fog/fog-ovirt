Shindo.tests("Fog::Ovirt::Compute.new | template model", ["ovirt"]) do
  templates = Fog::Ovirt::Compute.new.templates
  template = templates.last

  tests("The template model should") do
    tests("have the action") do
      test("reload") { template.respond_to? "reload" }
    end
    tests("have attributes") do
      model_attribute_hash = template.attributes
      attributes = %i[id name]

      tests("The template model should respond to") do
        attributes.each do |attribute|
          test(attribute.to_s) { template.respond_to? attribute }
        end
      end
      tests("The attributes hash should have key") do
        attributes.each do |attribute|
          test(attribute.to_s) { model_attribute_hash.key? attribute }
        end
      end
    end
    test("be a kind of Fog::Ovirt::Compute::Template") { template.is_a? Fog::Ovirt::Compute::Template }
  end
end
