Shindo.tests("Fog::Ovirt::Compute.new | instance types collection", ["ovirt"]) do
  instance_types = Fog::Ovirt::Compute.new.instance_types

  tests("The instance types collection") do
    test("should be a kind of Fog::Ovirt::Compute::InstanceTypes") { instance_types.is_a? Fog::Ovirt::Compute::InstanceTypes }
  end
end
