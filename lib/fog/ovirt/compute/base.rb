module Fog
  module Ovirt
    class Compute
      class Base
        # Max resources values for VMs depending on oVirt's version
        # These values can be found by running the engine-config command on the engine
        # with following config keys:
        # - MaxNumOfVmCpus
        # - MaxNumOfVmSockets
        # - VM64BitMaxMemorySizeInMB
        # - VM32BitMaxMemorySizeInMB,
        #
        # Eg:
        #
        # engine-config --get MaxNumOfVmCpus
        # MaxNumOfVmCpus: 288 version: 4.1
        # MaxNumOfVmCpus: 384 version: 4.2
        # MaxNumOfVmCpus: 384 version: 4.3
        #
        VM_MAX_VALUES = {
          # Default values for unknown version
          "unknown" => { :max_num_of_vm_cpus => 240,
                         :max_num_of_vm_sockets => 16,
                         :vm64_bit_max_memory_size_in_mb => 4_194_304,
                         :vm32_bit_max_memory_size_in_mb => 20_480 },
          "3.6" => { :max_num_of_vm_cpus => 240,
                     :max_num_of_vm_sockets => 16,
                     :vm64_bit_max_memory_size_in_mb => 4_194_304,
                     :vm32_bit_max_memory_size_in_mb => 20_480 },
          "4.0" => { :max_num_of_vm_cpus => 240,
                     :max_num_of_vm_sockets => 16,
                     :vm64_bit_max_memory_size_in_mb => 4_194_304,
                     :vm32_bit_max_memory_size_in_mb => 20_480 },
          "4.1" => { :max_num_of_vm_cpus => 288,
                     :max_num_of_vm_sockets => 16,
                     :vm64_bit_max_memory_size_in_mb => 4_194_304,
                     :vm32_bit_max_memory_size_in_mb => 20_480 },
          "4.2" => { :max_num_of_vm_cpus => 384,
                     :max_num_of_vm_sockets => 16,
                     :vm64_bit_max_memory_size_in_mb => 4_194_304,
                     :vm32_bit_max_memory_size_in_mb => 20_480 },
          "4.3" => { :max_num_of_vm_cpus => 384,
                     :max_num_of_vm_sockets => 16,
                     :vm64_bit_max_memory_size_in_mb => 4_194_304,
                     :vm32_bit_max_memory_size_in_mb => 20_480 }
        }.freeze

        def initialize(options = {})
          @datacenter = options[:ovirt_datacenter]
        end

        def datacenter
          @datacenter ||= datacenter_hash[:id]
        end

        def datacenter_hash
          @datacenter_hash ||= datacenters.find { |x| x[:id] == @datacenter } if @datacenter
          @datacenter_hash ||= datacenters.first
        end

        def api_version
          raise NotImplementedError
        end

        def datacenter_version
          "unknown"
        end

        def max_num_of_vm_cpus
          vm_max_value(:max_num_of_vm_cpus)
        end

        def max_num_of_vm_sockets
          vm_max_value(:max_num_of_vm_sockets)
        end

        def vm64_bit_max_memory_size_in_mb
          vm_max_value(:vm64_bit_max_memory_size_in_mb)
        end

        def vm32_bit_max_memory_size_in_mb
          vm_max_value(:vm32_bit_max_memory_size_in_mb)
        end

        def vm_max_memory_size_in_mb
          vm64_bit_max_memory_size_in_mb
        end

        protected

        def vm_max_value(key)
          if VM_MAX_VALUES.key?(datacenter_version)
            VM_MAX_VALUES[datacenter_version][key]
          else
            VM_MAX_VALUES["unknown"][key]
          end
        end

        attr_reader :client
      end
    end
  end
end
