require 'thor'
require 'server_tools/support/shell_out'
require 'server_tools/bootstrap'
require 'server_tools/provision'
require 'server_tools/install_deb_package'

module ServerTools
  class CLI < Thor
    include ShellOut

    def self.exit_on_failure?
      true
    end

    class_option :identity_file,
                 desc: 'The private SSH key to use',
                 default: '$HOME/.ssh/id_rsa',
                 type: :string

    class_option :ssh_user,
                 desc: 'The user to SSH in as',
                 default: `whoami`.chomp,
                 type: :string

    class_option :ssh_port,
                 desc: 'The port to SSH into',
                 default: '22',
                 type: :string

    desc 'bootstrap HOSTNAME/IP', 'install Chef on HOSTNAME/IP'
    def bootstrap(hostname)
      shell_out(ServerTools::Bootstrap.new(hostname, options).command)
    end

    desc 'provision HOSTNAME/IP', 'run chef-client on host with given recipes/roles'
    option :chef_client_flags,
           desc: 'Options passed to chef-client',
           required: false,
           type: :string
    def provision(hostname)
      shell_out(ServerTools::Provision.new(hostname, options).command)
    end

    desc 'install-deb-package HOSTNAME', 'install a deb package on a remote host'
    option :deb_package_name,
           desc: 'The name of the deb package to install',
           required: true,
           type: :string

    option :deb_package_file,
           desc: 'The deb package to install',
           required: true,
           type: :string

    option :purge_older_version,
           desc: 'Purge the older version of the package?',
           required: false,
           defaut: false,
           type: :boolean

    def install_deb_package(hostname)
      install_deb_package = ServerTools::InstallDebPackage.new(hostname, options)
      shell_out(install_deb_package.copy_command)
      shell_out(install_deb_package.install_command)
    end
  end
end
