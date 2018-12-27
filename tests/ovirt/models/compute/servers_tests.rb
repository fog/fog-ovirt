Shindo.tests("Fog::Ovirt::Compute.new | servers collection", ["ovirt"]) do
  servers = Fog::Ovirt::Compute.new.servers

  tests("The servers collection") do
    test("should not be empty") { !servers.empty? }
    test("should be a kind of Fog::Ovirt::Compute::Servers") { servers.is_a? Fog::Ovirt::Compute::Servers }
    tests("should be able to reload itself").succeeds { servers.reload }
    tests("should be able to get a model") do
      tests("by instance uuid").succeeds { servers.get servers.first.id }
    end
  end
end
