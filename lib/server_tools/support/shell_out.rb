require 'bundler/setup'
require 'mixlib/shellout'

module ShellOut
  def shell_out(cmd, options: {})
    opts = options.merge(live_stdout: STDOUT, live_stderr: STDERR)
    shellout = Mixlib::ShellOut.new(cmd, opts)
    puts cmd
    Bundler.with_clean_env do
      shellout.run_command
    end
    handle_errors(shellout)
  end

  private

  def handle_errors(shellout)
    if shellout.error?
      STDERR.puts('Failure!')
      STDERR.puts("Exit code: #{shellout.exitstatus}")
      exit(shellout.exitstatus)
    end
  end
end
