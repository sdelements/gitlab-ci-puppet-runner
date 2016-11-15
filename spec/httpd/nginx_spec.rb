require 'spec_helper'

sde_version = ENV['SDE_VERSION'].gsub('.', '_')
base_name = "docs_sde_#{sde_version}_main"
ssl_artifacts = ['crt', 'key', 'client.crt']
chmod_owners = ['owner', 'group', 'others']
nginx_ports = [80, 443]

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

nginx_ports.each do |port|
  describe port("#{port}") do
    it { should be_listening }
  end
end

describe file("/etc/nginx/sites-available/#{base_name}.conf") do
  it { should exist }

  chmod_owners.each do |i|
    it { should be_readable.by("#{i}") }
  end

  its(:selinux_label) { should eq 'system_u:object_r:httpd_config_t:s0' }
end

describe file("/etc/nginx/sites-enabled/#{base_name}.conf") do
  it { should be_symlink }
  it { should be_linked_to "/etc/nginx/sites-available/#{base_name}.conf" }
end

ssl_artifacts.each do |i|
  describe file("/etc/nginx/#{base_name}.#{i}") do
    it { should exist }
    its(:selinux_label) { should eq 'system_u:object_r:httpd_config_t:s0' }
  end
end
