require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmConfigGet < Knife

      include Knife::ProxmoxBase

      banner "knife proxmox vm config get (options)"

      option :vmid,
        :short => "-I ID",
        :long  => "--vmid ID",
        :description => "The numeric identifier of the VM"

      option :field,
        :short => "-f field",
        :long  => "--field field",
        :default => "all",
        :description => "Which field to extract from the output"

      def run
        connection

        [:vmid].each do |param|
          check_config_parameter(param)
        end

        data = vm_config_get(config[:vmid], config[:field])

        ui.output(data)

      end
    end
  end
end
