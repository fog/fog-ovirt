require "spec_helper"
require "fog/bin"

describe Fog do
  describe "#providers" do
    it "includes existing providers" do
      assert_equal "Ovirt", Fog.providers[:ovirt]
    end
  end

  describe "#registered_providers" do
    it "includes existing providers" do
      assert_includes Fog.registered_providers, "Ovirt"
    end
  end

  describe "#available_providers" do
    it "includes existing providers" do
      assert_includes Fog.available_providers, "Ovirt" if Ovirt.available?
    end
  end

  describe "#services" do
    it "returns Hash of services" do
      assert_kind_of Hash, Fog.services
      assert_includes Fog.services, :cdn
      assert_includes Fog.services, :compute
      assert_includes Fog.services, :dns
      assert_includes Fog.services, :storage
    end
  end
end
