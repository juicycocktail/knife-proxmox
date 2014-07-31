require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmDelete < Knife
      include Knife::ProxmoxBase

      banner "knife proxmox vm delete (options)"

      # Options for this action
      option :purge,
        :short => "-P",
        :long => "--purge",
        :boolean => true,
        :default => false,
        :description => "Destroy corresponding node and client on the Chef Server."

      option :chef_node_name,
        :short => "-H hostname",
        :long => "--hostname hostname",
        :description => "The name of the node and client to delete, if it differs from the server name.  Only has meaning when used with the '--purge' option."
        
      option :vmid,
        :short => "-I ID",
        :long  => "--vmid ID",
        :description => "The numeric identifier of the VM"

      option :force,
        :short => "-y",
        :long  => "--yes",
        :description => "Force answer to yes (useful for scripting)"

      def run
        connection
        
        #TODO: must detect which parameter has been used: name or vmid
        vmid = nil
        if (config[:vmid].nil? and config[:chef_node_name].nil?) then
          ui.error("You must use -I <id> or -H <Hostname>")
          exit 1
        elsif (!config[:chef_node_name].nil?)
            name = config[:chef_node_name]
            vmid = server_name_to_vmid(name)
            puts "Server to destroy: #{name} [vmid: #{vmid}]"
            if (config[:force].nil?) then
              ui.confirm("Continue")
            end
        else
          vmid = config[:vmid]
        end
        
        begin
          vm_stop(vmid)
          sleep(3)
          vm_delete(vmid)
        rescue Exception => e
          ui.warn("Error trying to destroy the server. Does the server exist?")
          exit 1
        end
        
        #TODO: remove server from chef
        # if config[:purge]
        #   thing_to_delete = config[:chef_node_name] || server_get_data(config[:vmid],"name")
        #   destroy_item(Chef::Node, thing_to_delete, "node")
        #   destroy_item(Chef::ApiClient, thing_to_delete, "client")
        # else
        #   ui.warn("Corresponding node and client for the #{vmid} server were not deleted and remain registered with the Chef Server")
        # end
      end
      
    end
  end
end
