require "fog/core"
require "fog/xml"
require "fog/json"

module Fog
  module Ovirt
    autoload :Compute, "fog/ovirt/compute"

    extend Fog::Provider

    module Errors
      class ServiceError < Fog::Errors::Error; end
      class SecurityError < ServiceError; end
      class NotFound < ServiceError; end
      class OvirtError < Fog::Errors::Error; end

      class OvirtEngineError < OvirtError
        attr_reader :orig_exception

        def initialize(exception)
          @orig_exception = exception
          super("Ovirt client returned an error: #{@orig_exception.message}")
        end
      end
    end

    service(:compute, "Compute")
  end
end
