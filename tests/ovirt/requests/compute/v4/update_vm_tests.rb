Shindo.tests("Fog::Compute[:ovirt] v4 | vm_update request", ["ovirt"]) do
  compute = Fog::Compute.new(:provider => :ovirt, :api_version => "v4")
  if compute.servers.all(:search => "fog-*").empty?
    compute.create_vm(:name => "fog-" + Time.now.to_i.to_s, :cluster_name => "Default")
  end
  vm = compute.servers.all(:search => "fog-*").last

  tests("The response should") do
    response = compute.update_vm(:id => vm.id, :name => vm.name + "updated")
    test("be a kind of OvirtSDK4::Vm") { response.is_a? OvirtSDK4::Vm }
  end

  tests("The expected options") do
    raises(ArgumentError, "raises ArgumentError when id option is missing") { compute.update_vm }
  end
end
