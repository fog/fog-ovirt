Shindo.tests("Fog::Ovirt::Compute.new | interfaces collection", ["ovirt"]) do
  interfaces = Fog::Ovirt::Compute.new.interfaces

  tests("The interfaces collection") do
    test("should be a kind of Fog::Ovirt::Compute::Interfaces") { interfaces.is_a? Fog::Ovirt::Compute::Interfaces }
  end
end
