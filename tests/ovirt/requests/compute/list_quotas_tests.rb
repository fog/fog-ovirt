Shindo.tests("Fog::Compute[:ovirt] | quotas request", ["ovirt"]) do
  compute = Fog::Compute[:ovirt]

  tests("When listing all quotas") do
    response = compute.quotas
    tests("The response data format ...") do
      test("it should be a kind of Array") { response.is_a? Array }
    end
  end
end
