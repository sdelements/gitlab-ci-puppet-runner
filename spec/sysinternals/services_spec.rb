require 'spec_helper'

running_services = [
    'crond',
    'ntpd',
    'memcached',
    'auditd',
    'postfix',
    'iptables',
    'rsyslog'
]

running_services.each do |i|
  describe service("#{i}") do
    it {should be_enabled }
    it {should be_running }
  end
end
