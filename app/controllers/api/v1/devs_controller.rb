class Api::V1::DevsController < ApiController
  respond_to :json

  def index
    respond_with User.where("users.career_status IS NOT NULL AND users.career_status != 'Unavailable'").order('id DESC')
  end
end