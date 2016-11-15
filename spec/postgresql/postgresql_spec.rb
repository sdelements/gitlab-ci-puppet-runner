require 'spec_helper'

sde_version = ENV['SDE_VERSION'].gsub('.', '_')
query_cmd = 'sudo su - postgres -c \'psql -c "select datname from pg_database"\''

describe package('postgresql') do
  it { should be_installed }
end

describe service('postgresql-9.4') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5432) do
  it { should be_listening }
end

describe command("#{query_cmd}") do
  its(:stdout) { should contain("docs_sde_#{sde_version}") }
end
