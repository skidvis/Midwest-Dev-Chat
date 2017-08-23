class Api::V1::JobsController < ApiController
  respond_to :json

  def index
    jobs = Job.all.order('post_date DESC')
    jobs = jobs.remote_options(params[:remote_options]) if params[:remote_options].present?
    jobs = jobs.title_like(params[:title_like]) if params[:title_like].present?
    jobs = jobs.description_like(params[:description_like]) if params[:description_like].present?
    respond_with jobs
  end
end