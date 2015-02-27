class HomeController < ApplicationController
  require 'rails_rinku'
  before_filter :get_members

  def index
    response = HTTParty.get("https://slack.com/api/channels.history?token=#{Rails.application.secrets.slack_token}&channel=#{Rails.application.secrets.slack_channel}&pretty=1&count=15")
    @messages = response['messages']
  end

  def create
    if params['email'].present?
      SignupMailer.signup(params['email']).deliver_later

      cookies[:signed_up] = true
      redirect_to home_index_path
    end
  end

  private

  def get_members
    if Member.all.size == 0
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
end
