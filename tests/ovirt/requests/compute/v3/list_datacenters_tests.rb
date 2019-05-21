Shindo.tests("Fog::Ovirt::Compute | datacenters request", ["ovirt"]) do
  compute = Fog::Ovirt::Compute.new

  tests("When listing all datacenters") do
    response = compute.datacenters
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
      test("be a kind of Hash") { response.first.is_a? Hash }
    end
  end
end
