Shindo.tests('Fog::Compute[:ovirt] | operating_systems collection', ['ovirt']) do

  operating_systems = Fog::Compute[:ovirt].operating_systems

  tests('The servers collection') do
    test('should not be empty') { not operating_systems.empty? }
    test('should be a kind of Fog::Compute::Ovirt::OperatingSystems') { operating_systems.kind_of? Fog::Compute::Ovirt::OperatingSystems }
  end

end
