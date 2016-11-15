require 'spec_helper'

describe port(9001) do
  it { should be_listening }
end

describe service('sde_celery') do
  it { should be_running.under('supervisor')}
end