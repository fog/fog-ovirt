Shindo.tests("Fog::Ovirt::Compute.new v4 | storage_domains request", ["ovirt"]) do
  compute = Fog::Compute.new(:provider => :ovirt, :api_version => "v4")

  tests("When listing all storage_domains") do
    response = compute.storage_domains
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
      test("be a kind of OvirtSDK4::StorageDomain") { response.first.is_a? OvirtSDK4::StorageDomain }
    end
  end
end
