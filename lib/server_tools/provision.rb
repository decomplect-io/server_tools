require 'server_tools/support/ssh'

module ServerTools
  class Provision
    include SSH
    def initialize(hostname, options)
      @hostname = hostname
      @options = options
    end

    def command
      [
        "ssh #{hostname}",
        "-t -t",
        "#{ssh_opts(options)}",
        "sudo /usr/bin/chef-client #{options[:chef_client_flags]}"
      ].join(' ')
    end

    private

    attr_reader :hostname, :options
  end
end
