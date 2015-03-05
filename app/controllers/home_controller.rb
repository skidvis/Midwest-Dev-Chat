class HomeController < ApplicationController
  require 'rails_rinku'
  before_filter :get_members
  before_filter :get_channels

  def index
    Fake.all.each {|x| x.destroy}

    if params['slack_id'].present?
      restricted_channels = Rails.application.secrets.restricted_channels
      params['slack_id'] = '' if restricted_channels.any?{ |rc| params['slack_id'].include? rc }
    end

    channel = Channel.find_by_name(params['slack_id']) || Channel.find_by_slack_id(Rails.application.secrets.slack_channel)

    response = HTTParty.get("https://slack.com/api/channels.history?token=#{Rails.application.secrets.slack_token}&channel=#{channel.slack_id}&pretty=1&count=15")
    @messages = response['messages'].reverse!
    @channels = Channel.all
    @current_channel = channel.name
  end

  def create
    if params['email'].present? && params['email'].include?('@')
      SignupMailer.signup(params['email']).deliver_later

      cookies[:signed_up] = true
    end

    redirect_to home_index_path
  end

  private

  def get_members
    SlackHelper.update_members if Member.count == 0
  end

  def get_channels
    SlackHelper.update_channels if Channel.count == 0
  end
end
