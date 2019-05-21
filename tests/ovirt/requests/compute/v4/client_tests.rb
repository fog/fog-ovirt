Shindo.tests("Fog::Ovirt::Compute.new | client", ["ovirt"]) do
  before do
    @client_mock = Object.new
    def @client_mock.foo
      raise OVIRT::OvirtException, "Test"
    end

    @object_under_test = Fog::Ovirt::Compute::ExceptionWrapper.new(@client_mock)
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
