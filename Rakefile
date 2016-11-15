require 'rake'
require 'rspec/core/rake_task'

task :spec => 'spec:all'
task :default => :spec

# Pull hosts to test from environment variable
hosts = ENV['SERVER_SPEC_HOSTS'].split(',')

namespace :spec do
  task :all => hosts.map {|h| 'spec:' + h.split('.')[0]}
  hosts.each do |host|
    short_name = host.split('.')[0]
    desc "Run serverspec to #{host}"
    RSpec::Core::RakeTask.new(short_name) do |t|
      ENV['TARGET_HOST'] = host
      t.pattern = 'spec/**/*_spec.rb'
    end
  end
end
