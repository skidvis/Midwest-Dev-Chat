namespace :slack do
  desc "Gets the latest Slack channels"

  task update_channels: :environment do
    SlackHelper.update_channels
  end

end
