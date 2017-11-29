Shindo.tests("Fog::Compute[:ovirt] | clusters collection", ["ovirt"]) do
  clusters = Fog::Compute[:ovirt].clusters

  tests("The clusters collection") do
    test("should be a kind of Fog::Compute::Ovirt::Clusters") { clusters.is_a? Fog::Compute::Ovirt::Clusters }
  end
end
