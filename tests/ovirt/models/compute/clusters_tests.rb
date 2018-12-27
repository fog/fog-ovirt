Shindo.tests("Fog::Ovirt::Compute.new | clusters collection", ["ovirt"]) do
  clusters = Fog::Ovirt::Compute.new.clusters

  tests("The clusters collection") do
    test("should be a kind of Fog::Ovirt::Compute::Clusters") { clusters.is_a? Fog::Ovirt::Compute::Clusters }
  end
end
