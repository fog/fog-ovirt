require "fog/ovirt/core"

module Fog
  module Compute
    class Ovirt < Fog::Service
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

      class ExceptionWrapper
        def initialize(client)
          @client = client
        end

        # rubocop:disable Style/MethodMissing
        def method_missing(symbol, *args)
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

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
        # rubocop:enable Style/MethodMissing
      end

      require "fog/ovirt/compute/v3"
      require "fog/ovirt/compute/v4"

      def self.new(options = {})
        super(options)

        # rubocop:disable Style/ConditionalAssignment
        if options[:api_version] == "v4"
          @client = Fog::Compute::Ovirt::V4.new(options)
        else
          @client = Fog::Compute::Ovirt::V3.new(options)
        end
        # rubocop:enable Style/ConditionalAssignment
      end

      # rubocop:disable Style/MethodMissing
      def method_missing(symbol, *args)
        @client.__send__(symbol, *args)
      end

      def respond_to?(symbol, include_all = false)
        @client.respond_to?(symbol, include_all)
      end
      # rubocop:enable Style/MethodMissing

      class Mock
        def initialize(options = {})
          if options[:api_version] == "v4"
            Fog::Compute::Ovirt::V4::Mock.send(:include, Fog::Compute::Ovirt::Collections)
            @client = Fog::Compute::Ovirt::V4::Mock.new(options)
          else
            Fog::Compute::Ovirt::V3::Mock.send(:include, Fog::Compute::Ovirt::Collections)
            @client = Fog::Compute::Ovirt::V3::Mock.new(options)
          end
        end

        # rubocop:disable Style/MethodMissing
        def method_missing(symbol, *args)
          @client.__send__(symbol, *args)
        end

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
        # rubocop:enable Style/MethodMissing
      end

      class Real
        def initialize(options = {})
          if options[:api_version] == "v4"
            Fog::Compute::Ovirt::V4::Real.send(:include, Fog::Compute::Ovirt::Collections)
            @client = Fog::Compute::Ovirt::V4::Real.new(options)
          else
            Fog::Compute::Ovirt::V3::Real.send(:include, Fog::Compute::Ovirt::Collections)
            @client = Fog::Compute::Ovirt::V3::Real.new(options)
          end
        end

        # rubocop:disable Style/MethodMissing
        def method_missing(symbol, *args)
          @client.send(symbol, *args)
        end

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
        # rubocop:enable Style/MethodMissing
      end
    end
  end
end
