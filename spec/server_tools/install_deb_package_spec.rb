require 'spec_helper'

describe ServerTools::InstallDebPackage do
  before do
    @opts = {
      identity_file: '~/.ssh/id_rsa',
      ssh_user: 'deployer',
      ssh_port: '1234',
      deb_package_name: 'deb_package',
      deb_package_file: '/tmp/file.deb'
    }
  end
  describe '#copy_command' do
    it 'returns the correct command' do
      install_deb_package = ServerTools::InstallDebPackage.new('localhost', @opts)
      expected = "rsync -avz -e \"ssh -p 1234 -i ~/.ssh/id_rsa -l deployer -o StrictHostKeyChecking=no " \
                 "-o UserKnownHostsFile=/dev/null\" --progress --partial /tmp/file.deb deployer@localhost:~/"
      expect(install_deb_package.copy_command).to eq(expected)
    end
  end
  describe '#install_command' do
    describe 'with purge older options' do
      before do
        @opts = @opts.merge(purge_older_version: true)
      end
      it 'returns the correct command' do
        install_deb_package = ServerTools::InstallDebPackage.new('localhost', @opts)
        expected = "ssh localhost -t -t -p 1234 -i ~/.ssh/id_rsa -l deployer -o StrictHostKeyChecking=no -o " \
                   "UserKnownHostsFile=/dev/null sudo dpkg -P deb_package && sudo dpkg -i ~/file.deb"
        expect(install_deb_package.install_command).to eq(expected)
      end
    end
    describe 'with no-purge-older-version option' do
      before do
        @opts = @opts.merge(purge_older_version: false)
      end
      it 'returns the correct command' do
        install_deb_package = ServerTools::InstallDebPackage.new('localhost', @opts)
        expected = "ssh localhost -t -t -p 1234 -i ~/.ssh/id_rsa -l deployer -o StrictHostKeyChecking=no -o " \
                   "UserKnownHostsFile=/dev/null sudo dpkg -i ~/file.deb"
        expect(install_deb_package.install_command).to eq(expected)
      end
    end
  end
end
