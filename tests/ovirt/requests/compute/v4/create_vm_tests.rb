Shindo.tests("Fog::Ovirt::Compute v4 | vm_create request", "ovirt") do
  compute = Fog::Ovirt::Compute.new(:api_version => "v4")
  name_base = Time.now.to_i

  tests("Create VM") do
    response = compute.create_vm(:name => "fog-" + name_base.to_s, :cluster_name => "Default")
    test("should be a kind of OvirtSDK4::Vm") { response.is_a? OvirtSDK4::Vm }
    test("should be a 'OvirtSDK4::VmType::SERVER' VM type by default") { response.type == OvirtSDK4::VmType::SERVER }
  end

  tests("Create VM from template (clone)") do
    response = compute.create_vm(:name => "fog-" + (name_base + 1).to_s, :template_name => "hwp_small", :cluster_name => "Default")
    test("should be a kind of OvirtSDK4::Vm") { response.is_a? OvirtSDK4::Vm }
  end

  # TODO: Write a test for situation where creating a VM fails
  #  mocks never raise exceptions
end
