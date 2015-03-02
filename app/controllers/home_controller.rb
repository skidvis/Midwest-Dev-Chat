class HomeController < ApplicationController
  require 'rails_rinku'
  before_filter :get_members
  before_filter :get_channels

  def index
    Fake.all.each {|x| x.destroy}

    channel_id = params['slack_id'] || Rails.application.secrets.slack_channel
    response = HTTParty.get("https://slack.com/api/channels.history?token=#{Rails.application.secrets.slack_token}&channel=#{channel_id}&pretty=1&count=15")
    @messages = response['messages'].reverse!
    @channels = Channel.all
    @current_channel = Channel.find_by_slack_id(channel_id)
  end

  def create
    if params['email'].present? && params['email'].include?('@')
      SignupMailer.signup(params['email']).deliver_later

      cookies[:signed_up] = true
    end

    redirect_to home_index_path
  end

  def set_channel
    binding.pry
  end

  private

  def get_members
    if Member.count == 0
      members = HTTParty.get("https://slack.com/api/users.list?token=#{Rails.application.secrets.slack_token}&pretty=1")
      if members['ok'].presence
        members['members'].each do |member|
          new_member = Member.new do |m|
            m.slack_id = member['id']
            m.name = member['name']
            m.color = member['color']
            m.save
          end
        end
      end
    end
  end

  def get_channels
    if Channel.count == 0
      channels = HTTParty.get("https://slack.com/api/channels.list?token=#{Rails.application.secrets.slack_token}&pretty=1")
      if channels['ok'].presence
        channels['channels'].each do |channel|
          new_channel = Channel.new do |c|
            c.slack_id = channel['id']
            c.name = channel['name']
            c.save
          end
        end
      end
    end
  end
end
