require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmDelete < Knife
      include Knife::ProxmoxBase

      banner "knife proxmox vm delete (options)"

      option :vmid,
        :long  => "--vmid ID",
        :description => "The numeric identifier of the VM"

      def run
        connection
        
        [:vmid].each do |param|
          check_config_parameter(param)
        end

        begin
          vm_delete(config[:vmid])
        rescue Exception => e
          ui.warn("Error trying to destroy the server. Does the server exist?")
          exit 1
        end
      end
      
    end
  end
end
