module LinkHelper
  def self.process_links message
    user = Member.find_by_slack_id(message['user']) || add_new_user(message['user'])
    message_date = DateTime.strptime(message['ts'],'%s').in_time_zone('Central Time (US & Canada)').strftime('%m/%d %H:%M:%S')

    message = find_members_in_text(message['text'])
    message = find_urls_in_text(message)
    message = find_code_in_text(message)
    message = find_emojis_in_text(message)

    "<span class='date'>#{message_date}</span> <span class='member' style='color: ##{user.color}'>#{user.name}:</span> <span>#{message}</span>"
  end

  def self.find_members_in_text(message)
    message.gsub(/<@(\w*)>/) do
      found_user_id = Regexp.last_match[1].split('|').first
      if found_user_id.present?
        found_user = Member.find_by_slack_id(found_user_id) || add_new_user(found_user_id)
        "<span class='member' style='color:##{found_user.color}'>@#{found_user.name}</span>"
      end
    end
  end

  def self.find_urls_in_text(message)
    message.gsub(/<(http.*)>/){ Rinku.auto_link("#{$1.split('|').first}") }
  end

  def self.find_code_in_text(message)
    message.gsub(/`{3}(?:(.*$)\n)?([\s\S]*)`{3}/){ "<pre>#{$2}</pre>" }
  end

  def self.find_emojis_in_text(message)
    message.gsub(/:(\w*):/) do
      emoji = Regexp.last_match[1]
      "<img src = '/emojis/#{emoji}.png' alt='#{emoji}' class='emoji' />"
    end
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