Shindo.tests("Fog::Compute[:ovirt] v4 | quotas request", ["ovirt"]) do
  compute = Fog::Compute.new(:provider => :ovirt, :api_version => "v4")

  tests("When listing all quotas") do
    response = compute.quotas
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
    end
  end
end
