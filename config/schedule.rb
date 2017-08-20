set :environment, 'production'
set :output, {:error => 'log/cron_error_log.log', :standard => 'log/cron_log.log'}

every 1.day, :at => '11:59 pm' do
  rake 'slack:update_channels'
  rake 'careers:update_jobs'
  rake 'careers:post_to_slack'
end