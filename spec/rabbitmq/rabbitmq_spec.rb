require 'spec_helper'

sde_version = ENV['SDE_VERSION'].gsub('.', '_')

describe service('rabbitmq-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5672) do
  it { should be_listening }
end

describe command('sde rabbitmqctl list_vhosts') do
  its(:stdout) { should contain("docs_sde_#{sde_version}") }
end
