require 'chef/knife/proxmox_base'

class Chef
  class Knife
    class ProxmoxVmClone < Knife
      
      include Knife::ProxmoxBase
      
      banner "knife proxmox vm clone (options) [QEMU]"
    
      option :vmid,
        :long  => "--vmid vmid",
        :description => "VMID to clone"

      option :name,
        :long  => "--name name",
        :description => "Name for the new new VM"

      option :pool,
        :long  => "--pool pool",
        :description => "Pool for the new new VM"

      option :storage,
        :long  => "--storage storage",
        :description => "Target storage for full clone"

      option :target,
        :long  => "--target node",
        :description => "Node name to clone onto"

      option :full,
        :long => "--full",
        :boolean => true,
        :default => false,
        :description => "Create full copy of all disks."

      def run
        connection

        [:vmid].each do |param|
          check_config_parameter(param)
        end

        vm_config = Hash.new
        vm_config[:newid] = config[:newid] ||= new_vmid
        vm_config[:target] = config[:target] if config[:target]
        vm_config[:name] = config[:name]  if config[:name] 
        vm_config[:pool] = config[:pool]  if config[:pool] 
        vm_config[:storage] = config[:storage]  if config[:storage] 
        vm_config[:full] = 1 if config[:full]
        puts vm_config

        vm_definition = vm_config.to_a.map { |v| v.join '=' }.join '&'
        puts vm_definition
        vm_clone(config[:vmid], vm_config[:newid], vm_definition)

      end  
    end
  end
end
     

