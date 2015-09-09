require 'spec_helper'

describe ServerTools::Provision do
  it 'returns the correct provision command' do
    opts = {
      identity_file: '~/.ssh/id_rsa',
      ssh_user: 'deployer',
      ssh_port: '1234',
      roles: %w(web db)
    }
    provision = ServerTools::Provision.new('localhost', opts)
    expected = "ssh localhost -p 1234 -i ~/.ssh/id_rsa -l deployer -t -t -o StrictHostKeyChecking=no -o " \
               "UserKnownHostsFile=/dev/null sudo /usr/bin/chef-client -o'web,db'"
    expect(provision.command).to eq(expected)
  end
end
