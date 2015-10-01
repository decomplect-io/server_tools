require 'spec_helper'

describe ServerTools::Bootstrap do
  it 'returns the correct bootstrap command' do
    opts = {
      identity_file: '~/.ssh/id_rsa',
      ssh_user: 'deployer',
      ssh_port: '1234'
    }
    bootstrap = ServerTools::Bootstrap.new('localhost', opts)
    expected = "knife bootstrap localhost --identity-file ~/.ssh/id_rsa " \
               "--ssh-port 1234 --ssh-user deployer --sudo --local-mode"
    expect(bootstrap.command).to eq(expected)
  end
end
