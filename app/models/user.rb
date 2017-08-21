class User < ActiveRecord::Base
  validates :slackhandle, presence: true, uniqueness: { scope: :slackhandle,  message: "already exists" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :jobs,  dependent: :destroy 

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :slackhandle
    ]
  end
end
