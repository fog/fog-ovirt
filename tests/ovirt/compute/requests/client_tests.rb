Shindo.tests("Fog::Compute[:ovirt] | client", ["ovirt"]) do
  before do
    @client_mock = Object.new
    def @client_mock.foo
      raise OVIRT::OvirtException, "Test"
    end

    @object_under_test = Fog::Compute::Ovirt::ExceptionWrapper.new(@client_mock)
  end

  tests("Raises the right type of exception")
    .raises(Fog::Ovirt::Errors::OvirtEngineError) do
    @object_under_test.foo
  end

  tests("The exception test is as expected").returns(true) do
    begin
      @object_under_test.foo
    rescue Fog::Ovirt::Errors::OvirtEngineError => e
      e.message == "Ovirt client returned an error: Test"
    end
  end

  tests("The original exception test is as expected").returns(true) do
    begin
      @object_under_test.foo
    rescue Fog::Ovirt::Errors::OvirtEngineError => e
      e.orig_exception.message == "Test"
    end
  end
end
