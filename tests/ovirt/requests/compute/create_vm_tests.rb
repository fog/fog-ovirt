Shindo.tests("Fog::Compute[:ovirt] | vm_create request", "ovirt") do
  compute = Fog::Compute[:ovirt]
  name_base = Time.now.to_i

  tests("Create VM") do
    response = compute.create_vm(:name => "fog-" + name_base.to_s, :cluster_name => "Default")
    test("should be a kind of OVIRT::VM") { response.is_a? OVIRT::VM }
  end

  tests("Create VM from template (clone)") do
    response = compute.create_vm(:name => "fog-" + (name_base + 1).to_s, :template_name => "hwp_small", :cluster_name => "Default")
    test("should be a kind of OVIRT::VM") { response.is_a? OVIRT::VM }
  end

  # TODO: Write a test for situation where creating a VM fails
  #  mocks never raise exceptions
end
