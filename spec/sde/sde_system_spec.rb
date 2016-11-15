require 'spec_helper'

logrotate_rules = ['nginx', 'apache', 'celery', 'almsync']

describe file('/docs/sde/.ssh/id_rsa') do
  it { should exist }
end

describe file('/etc/sde/custom.yaml') do
  it { should exist }
end

logrotate_rules.each do |rule|
  describe file("/etc/logrotate.d/sde_#{rule}_logrotation") do
    it { should exist }
  end
end

describe file('/docs/sde/live/code/webroot/500.html') do
  it { should exist }
end

describe file('/root/.pgpass') do
  it { should exist }
end

