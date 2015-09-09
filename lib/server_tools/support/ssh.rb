module SSH
  def ssh_opts(options)
    <<-OPTS
      -p #{options[:ssh_port]}
      -i #{options[:identity_file]}
      -l #{options[:ssh_user]}
      -t
      -t
      -o StrictHostKeyChecking=no
      -o UserKnownHostsFile=/dev/null
    OPTS
  end
end
