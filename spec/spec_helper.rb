require 'serverspec'
require 'net/ssh'

set :backend, :ssh

remote_user = ENV['TARGET_USER']
remote_host = ENV['TARGET_HOST']

# TODO: why does OS detection fail for me locally - RAM
set :os, :family => 'redhat', :release => '6', :arch => 'x86_64'

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail 'highline is not available. Try installing it.'
  end
  set :sudo_password, ask('Enter sudo password: ') { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)

options[:user] = ENV['TARGET_USER']

if ENV['ASK_LOGIN_PASSWORD']
  options[:password] = ask("\n#{remote_user}@#{remote_host}'s password: ") { |q| q.echo = false }
else
  options[:password] = ENV['LOGIN_PASSWORD']
end

set :host,        options[:host_name] || host
set :ssh_options, options
