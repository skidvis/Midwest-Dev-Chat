class Job < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user

  scope :remote_options, -> (remote_options) { where remote_options: remote_options }
  scope :title_like, -> (title) { where("title like ?", "%#{title}%")}
  scope :description_like, -> (description) { where("description like ?", "%#{description}%")}

  validates :url, :url => true

  def slug_candidates
    [
      :title,
      [:company, :title]
    ]
  end
end
