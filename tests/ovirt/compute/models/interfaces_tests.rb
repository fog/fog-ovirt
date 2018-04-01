Shindo.tests("Fog::Compute[:ovirt] | interfaces collection", ["ovirt"]) do
  interfaces = Fog::Compute[:ovirt].interfaces

  tests("The interfaces collection") do
    test("should be a kind of Fog::Compute::Ovirt::Interfaces") { interfaces.is_a? Fog::Compute::Ovirt::Interfaces }
  end
end
