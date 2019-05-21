Shindo.tests("Fog::Ovirt::Compute.new | templates collection", ["ovirt"]) do
  templates = Fog::Ovirt::Compute.new.templates

  tests("The templates collection") do
    test("should be a kind of Fog::Ovirt::Compute::Templates") { templates.is_a? Fog::Ovirt::Compute::Templates }
  end
end
