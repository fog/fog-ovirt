require "fog/ovirt/core"

module Fog
  module Compute
    class Ovirt < Fog::Service
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
            @client.send(symbol, *args) do |*block_args|
              yield(*block_args)
            end
          else
            @client.send(symbol, *args)
          end
        rescue ::OVIRT::OvirtException => e
          raise ::Fog::Ovirt::Errors::OvirtEngineError, e
        end

        def respond_to?(symbol, include_all = false)
          @client.respond_to?(symbol, include_all)
        end
        # rubocop:enable Style/MethodMissing
      end

      require "fog/ovirt/compute/v3"

      def self.new(options = {})
        super()
        @client = Fog::Compute::Ovirt::V3.new(options)
      end

      # rubocop:disable Style/MethodMissing
      def method_missing(symbol, *args)
        @client.send(symbol, *args)
      end

      def respond_to?(symbol, include_all = false)
        @client.respond_to?(symbol, include_all)
      end
      # rubocop:enable Style/MethodMissing

      class Mock
        def initialize(options = {})
          Fog::Compute::Ovirt::V3::Mock.send(:include, Fog::Compute::Ovirt::Collections)
          @client = Fog::Compute::Ovirt::V3::Mock.new(options)
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

      class Real
        def initialize(options = {})
          Fog::Compute::Ovirt::V3::Real.send(:include, Fog::Compute::Ovirt::Collections)
          @client = Fog::Compute::Ovirt::V3::Real.new(options)
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
