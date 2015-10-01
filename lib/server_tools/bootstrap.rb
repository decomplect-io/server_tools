module ServerTools
  class Bootstrap
    def initialize(hostname, options)
      @hostname = hostname
      @options = options
    end

    def command
      [
        "knife bootstrap #{hostname}",
        "--identity-file #{options[:identity_file]}",
        "--ssh-port #{options[:ssh_port]}",
        "--ssh-user #{options[:ssh_user]}",
        "--sudo",
        "--local-mode"
      ].join(' ')
    end

    private

    attr_reader :hostname, :options
  end
end
