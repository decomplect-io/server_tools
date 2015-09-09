require 'server_tools/support/ssh'

module ServerTools
  class InstallDebPackage
    include SSH
    def initialize(hostname, options)
      @hostname = hostname
      @options = options
    end

    def copy_command
      <<-COMMAND
        rsync -avz
        -e "ssh #{ssh_opts(options)}"
        --progress
        --partial
        #{options[:deb_package_file]}
        #{options[:ssh_user]}@#{hostname}:~/
      COMMAND
    end

    def install_command
      ["ssh #{hostname}", "#{ssh_opts(options)}"].tap do |command|
        command << 'set -e'
        command << purge_command if options[:purge_older_version]
        command << "sudo dpkg -i ~/#{File.basename(options[:deb_package_file])}"
      end.join(' ')
    end

    private

    def purge_command
      "sudo dpkg -P #{options[:deb_package_name]}"
    end

    attr_reader :hostname, :options
  end
end
