require 'server_tools/support/ssh'

module ServerTools
  class InstallDebPackage
    include SSH
    def initialize(hostname, options)
      @hostname = hostname
      @options = options
    end

    def copy_command
      [
        "rsync -avz",
        %(-e "ssh #{ssh_opts(options)}"),
        "--progress --partial",
        "#{options[:deb_package_file]}",
        "#{options[:ssh_user]}@#{hostname}:~/"
      ].join(' ')
    end

    def install_command
      ["ssh #{hostname}", "-t -t", "#{ssh_opts(options)}"].tap do |command|
        if options[:purge_older_version]
          command << "#{purge_command} && #{_install_command}"
        else
          command << _install_command
        end
      end.join(' ')
    end

    private

    def purge_command
      "sudo dpkg -P #{options[:deb_package_name]}"
    end

    def _install_command
      "sudo dpkg -i ~/#{File.basename(options[:deb_package_file])}"
    end

    attr_reader :hostname, :options
  end
end
