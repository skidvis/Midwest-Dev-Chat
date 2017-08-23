class JobSerializer < ActiveModel::Serializer

  attributes :title, :description, :company, :url, :remote_options

  attribute :post_date do
    object.post_date.strftime('%F')
  end

  attribute :posted_by do
    user = User.find_by(id: object.user_id)
    user.slackhandle if user
  end

  attribute :mwdc_link do
    "https://#{ActionMailer::Base.smtp_settings[:domain]}/jobs/#{object.slug}"
  end
end
