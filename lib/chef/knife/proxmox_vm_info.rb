require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmInfo < Knife

      include Knife::ProxmoxBase

      banner "knife proxmox vm info (options)"

      option :vmid,
        :short => "-I ID",
        :long  => "--vmid ID",
        :description => "The numeric identifier of the VM"

      option :field,
        :short => "-f field",
        :long  => "--field field",
        :description => "Which field to extract from the output"

      def run
        connection

        [:vmid].each do |param|
          check_config_parameter(param)
        end

        field = config[:field] ||= "all"

        data = vm_info(config[:vmid], field)

        ui.output(data)

      end
    end
  end
end
