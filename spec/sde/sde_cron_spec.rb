require 'spec_helper'

sde_version = ENV['SDE_VERSION'].gsub('.', '_')

cron_tasks = [
    '0 0 * * * sde manage_django almsync daily > /dev/null 2>&1',
    %Q[0 0 * * * sde manage_django rebuild_index --verbosity=0 --noinput 2>&1 | awk '{ print strftime("\\%Y-\\%m-\\%d \\%H:\\%M:\\%S"), \\; }' >> /docs/sde/log/haystack_docs_sde_#{sde_version}.log],
    '0 * * * * sde manage_django almsync hourly > /dev/null 2>&1',
    '0 0 1 * * sde manage_django almsync monthly > /dev/null 2>&1',
    %Q[*/20 * * * * find /docs/sde/#{ENV['SDE_VERSION']}/backup -maxdepth 1 -mtime +7 -type d -name '*-*-*' -exec rm -Rf {} \\;],
    %Q[*/30 * * * * sde manage_django update_index -a 1 --verbosity=0 2>&1 | awk '{ print strftime("\\%Y-\\%m-\\%d \\%H:\\%M:\\%S"), \\; }' >> /docs/sde/log/haystack_docs_sde_#{sde_version}.log],
    '*/20 * * * * sde database auto_backup_db'
]

cron_tasks.each do |tasks|
  describe cron do
    it { should have_entry("#{tasks}").with_user('sde_admin') }
  end
end
