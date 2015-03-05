module SlackHelper
  def self.update_members
    members = HTTParty.get("https://slack.com/api/users.list?token=#{Rails.application.secrets.slack_token}&pretty=1")

    if members['ok'].presence
      members['members'].find_or_create_by(slack_id: member['id']) do |member|
        new_member = Member.new do |m|
          m.slack_id = member['id']
          m.name = member['name']
          m.color = member['color']
          m.save
        end
      end
    end
  end

  def self.update_channels
    channels = HTTParty.get("https://slack.com/api/channels.list?token=#{Rails.application.secrets.slack_token}&pretty=1")

    if channels['ok'].presence
      channels['channels'].each do |channel|
        new_channel = Channel.find_or_create_by(name: channel['name']) do |c|
          c.slack_id = channel['id']
          c.name = channel['name']
          c.save
        end
      end
    end
  end
end