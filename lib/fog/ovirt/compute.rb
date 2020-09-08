module Fog
  module Ovirt
    class Compute < Fog::Service
      recognizes :api_version, :ovirt_username, :ovirt_password, :ovirt_url,
                 :ovirt_datacenter, :ovirt_ca_cert_store, :public_key

      model_path "fog/ovirt/models/compute"
      model      :server
      collection :servers
      model      :template
      collection :templates
      model      :instance_type
      collection :instance_types
      model      :cluster
      collection :clusters
      model      :interface
      collection :interfaces
      model      :operating_system
      collection :operating_systems
      model      :volume
      collection :volumes
      model      :quota
      collection :quotas
      model      :affinity_group
      collection :affinity_groups

      DISK_SIZE_TO_GB = 1024 * 1024 * 1024

      class ExceptionWrapper
        def initialize(client)
          @client = client
        end

        def method_missing(symbol, *args)
          super unless @client.respond_to?(symbol)

          if block_given?
            @client.__send__(symbol, *args) do |*block_args|
              yield(*block_args)
            end
          else
            @client.__send__(symbol, *args)
          end
        rescue StandardError => e
          raise ::Fog::Ovirt::Errors::OvirtEngineError, e
        end

        def respond_to_missing?(method_name, include_private = false)
          @client.respond_to?(symbol, include_all) || super
        end
      end

      require "fog/ovirt/compute/v4"

      def self.new(options = {})
        super(options)
        @client = Fog::Ovirt::Compute::V4.new(options)
      end

      def method_missing(symbol, *args)
        @client.__send__(symbol, *args)
      end

      def respond_to?(symbol, include_all = false)
        @client.respond_to?(symbol, include_all)
      end

      class Mock
        def initialize(options = {})
          Fog::Ovirt::Compute::V4::Mock.include Fog::Ovirt::Compute::Collections
          @client = Fog::Ovirt::Compute::V4::Mock.new(options)
        end

        def method_missing(symbol, *args)
          @client.__send__(symbol, *args)
        end

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
      end

      class Real
        def initialize(options = {})
          Fog::Ovirt::Compute::V4::Real.include Fog::Ovirt::Compute::Collections
          @client = Fog::Ovirt::Compute::V4::Real.new(options)
        end

        def method_missing(symbol, *args)
          @client.send(symbol, *args)
        end

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
      end
    end
  end
end
