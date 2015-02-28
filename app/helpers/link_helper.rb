module LinkHelper
  def self.process_links message
    user = Member.find_by_slack_id(message['user'])
    message_with_member_names = find_members_in_text(message['text'])
    message_with_urls = find_urls_in_text(message_with_member_names)
    message_date = DateTime.strptime(message['ts'],'%s').strftime('%m/%d %H:%M:%S')

    "<span class='date'>#{message_date}</span> <span class='member' style='color: ##{user.color}'>#{user.name}:</span> <span>#{message_with_urls}</span>"
  end

  def self.find_members_in_text(message)
    message.gsub(/<@(\w*)>/) do
      found_user_id = Regexp.last_match[1].split('|').first
      if found_user_id.present?
        found_user = Member.find_by_slack_id(found_user_id) || add_new_user(found_user_id)
        "<span class='member' style='color:##{found_user.color}'>#{found_user.name}</span>"
      end
    end
  end

  def self.find_urls_in_text(message)
    message.gsub(/<(http.*)>/){ Rinku.auto_link("#{$1}") }
  end

  def self.add_new_user(user_id)
    user = HTTParty.get("https://slack.com/api/users.info?token=#{Rails.application.secrets.slack_token}&user=#{user_id}&pretty=1")

    if user['ok'].presence
      user_info = user['user']
      member = Member.create(name: user_info['name'], slack_id: user_info['id'], color: user_info['color'])
    end

    member
  end
end