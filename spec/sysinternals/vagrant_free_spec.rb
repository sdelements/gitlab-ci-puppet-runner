require 'spec_helper'

describe user('vagrant') do
  it { should_not exist }
end

describe file('/home/vagrant') do
  it { should_not exist }
end

describe file('/etc/sudoers') do
  it {should_not contain('vagrant') }
end

describe file('/srv/Vagrantfile') do
  it { should_not exist }
end