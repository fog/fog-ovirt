require "fog/core"
require "fog/xml"

module Fog
  module Compute
    autoload :Ovirt, File.expand_path("ovirt/compute", __dir__)
  end

  module Ovirt
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
