require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmStart < Knife

      include Knife::ProxmoxBase

      banner "knife proxmox vm start (options)"

      option :vmid,
        :short => "-I number",
        :long  => "--vmid number",
        :description => "The numeric identifier of the VM"

      def run
        connection
        
        [:vmid].each do |param|
          check_config_parameter(param)
        end
        
        vm_start(config[:vmid])
      end
    end
  end
end
