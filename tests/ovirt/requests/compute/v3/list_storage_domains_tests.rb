Shindo.tests("Fog::Ovirt::Compute | storage_domains request", ["ovirt"]) do
  compute = Fog::Ovirt::Compute.new

  tests("When listing all storage_domains") do
    response = compute.storage_domains
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
      test("be a kind of OVIRT::StorageDomain") { response.first.is_a? OVIRT::StorageDomain }
    end
  end
end
