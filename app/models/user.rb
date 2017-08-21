class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :slackhandle, presence: true, uniqueness: { scope: :slackhandle,  message: "already exists" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  has_many :jobs,  dependent: :destroy 

  devise :omniauthable, :omniauth_providers => [:slack]

  def self.from_omniauth(auth)
      response = HTTParty.get("https://slack.com/api/users.info?token=#{Rails.application.secrets.slack_token}&user=#{auth.info.user_id}&pretty=1")

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.fullname = auth.info.name
        user.slackhandle = response['user']['name']
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
    end      
  end

  def slug_candidates
    [
      :fullname,
      [:fullname, :slackhandle]
    ]
  end
end
