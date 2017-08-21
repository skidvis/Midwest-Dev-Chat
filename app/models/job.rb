class Job < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user

  def slug_candidates
    [
      :title,
      [:company, :title]
    ]
  end
end
