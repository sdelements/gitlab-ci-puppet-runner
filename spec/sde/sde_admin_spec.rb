require 'spec_helper'

describe user('sde_admin') do
  it { should exist }
end

describe group('sde_admin') do
  it { should exist }
end

describe command('sde version') do
  its(:exit_status) { should eq 0 }
end
