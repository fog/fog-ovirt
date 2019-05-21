Shindo.tests("Fog::Ovirt::Compute.new v4 | datacenters request", ["ovirt"]) do
  compute = Fog::Compute.new(:provider => :ovirt, :api_version => "v4")

  tests("When listing all datacenters") do
    response = compute.datacenters
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
      test("be a kind of Hash") { response.first.is_a? Hash }
    end
  end
end
