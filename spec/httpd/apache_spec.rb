require 'spec_helper'

sde_version = ENV['SDE_VERSION'].gsub('.', '_')
chmod_owners = ['owner', 'group', 'others']
vhosts = ['admin', 'main']
private_ssl_artifacts = ['key', 'crt']
ssl_artifacts = ['sochi.sdelements.com.pem']

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

vhosts.each do |vhost|
  describe file("/etc/httpd/conf.d/25-docs_sde_#{sde_version}_#{vhost}.conf") do
    it { should exist }
    chmod_owners.each do |i|
      it { should be_readable.by("#{i}") }
    end
    its(:selinux_label) { should eq 'system_u:object_r:httpd_config_t:s0' }
  end
end

ssl_artifacts.each do |artifact|
  describe file("/etc/pki/tls/certs/#{artifact}") do
    it { should exist }
    chmod_owners.each do |i|
      it { should be_readable.by("#{i}") }
    end
    its(:selinux_label) { should eq 'system_u:object_r:cert_t:s0' }
  end
end