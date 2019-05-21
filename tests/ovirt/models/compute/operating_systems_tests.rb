Shindo.tests("Fog::Ovirt::Compute.new | operating_systems collection", ["ovirt"]) do
  operating_systems = Fog::Ovirt::Compute.new.operating_systems

  tests("The servers collection") do
    test("should not be empty") { !operating_systems.empty? }
    test("should be a kind of Fog::Ovirt::Compute::OperatingSystems") { operating_systems.is_a? Fog::Ovirt::Compute::OperatingSystems }
  end
end
