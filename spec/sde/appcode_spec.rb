require 'spec_helper'

sde_version = ENV['SDE_VERSION']
chmod_owners = ['owner', 'group', 'others']

sde_toplevel_dirs = ['deployable-releases', 'plugins', 'saml2', 'indexes', 'log']

describe file('/docs/sde') do
  it { should be_directory }
  chmod_owners.each do |owner|
    it { should be_readable.by("#{owner}") }
  end
  it { should be_writable.by_user('sde_admin') }
  its(:selinux_label) { should eq 'system_u:object_r:httpd_sys_content_t:s0' }

end

describe file('/docs/sde/live') do
  it { should be_symlink }
end

describe file('/docs/sde/live') do
  it { should be_linked_to "/docs/sde/#{sde_version}" }
end

describe file('/docs/sde/local_settings') do
  it { should be_linked_to "/docs/sde/#{sde_version}/../live/code/sigma/local_settings.py" }
end

describe file('/docs/sde/keyczar') do
  it { should be_linked_to "/docs/sde/#{sde_version}/keyczar" }
end

describe file('/docs/sde/static') do
  it { should be_linked_to "/docs/sde/#{sde_version}/../live/static" }
end

sde_toplevel_dirs.each do |dir|
  describe file("/docs/sde/#{dir}") do
    it { should exist }
  end
end

=begin
describe file('/docs/sde/updater.cfg') do
  it { should be_linked_to "/docs/sde/#{sde_version}/updater.cfg" }
end
=end