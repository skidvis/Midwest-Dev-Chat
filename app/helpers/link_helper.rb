module LinkHelper
  def self.process_links message
    user = Member.find_by_slack_id(message['user']) || add_new_user(message['user'])
    fake = Fake.find_by_real_name(user.name) || add_new_fake(user.name)

    message_date = DateTime.strptime(message['ts'],'%s').in_time_zone('Central Time (US & Canada)').strftime('%m/%d %H:%M:%S')

    message = find_members_in_text(message['text'])
    message = find_urls_in_text(message)
    message = find_code_in_text(message)
    message = find_emojis_in_text(message)

    "<span class='date'>#{message_date}</span> <span class='member' style='color: ##{user.color}'>#{fake.fake_name}:</span> <span>#{message}</span>"
  end

  def self.find_members_in_text(message)
    message.gsub(/<@(\w*)>/) do
      found_user_id = Regexp.last_match[1].split('|').first
      if found_user_id.present?
        found_user = Member.find_by_slack_id(found_user_id) || add_new_user(found_user_id)
        fake = Fake.find_by_real_name(found_user.name) || add_new_fake(found_user.name)
        "<span class='member' style='color:##{found_user.color}'>@#{fake.fake_name}</span>"
      end
    end
  end

  def self.find_urls_in_text(message)
    image_formats = %w(.gif .jpg .jpeg .png)

    message.gsub(/<(http.*)>/) do
      matched_content = $1
      if image_formats.any?{ |img| matched_content.include?(img) }
        if message.include?('uploaded')
          "<span class='private'>Private image uploaded, members only. Sorry.</span>"
        else
          "<span class='private hidden-gif'>Image File [click to view] <img class='hidden' src='#{matched_content.split('|').first}' /></span>"
        end
      else
        Rinku.auto_link("#{matched_content.split('|').first}")
      end
    end
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

  def self.add_new_fake(name)
    fake = Fake.create(real_name: name, fake_name: Faker::Name.first_name)
  end
end