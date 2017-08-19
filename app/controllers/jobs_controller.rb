class JobsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    @jobs = Job.where(user: current_user).order('post_date DESC')
  end

  def new
      @job = Job.new
  end

  def create
    return unless params['job']

    params['job']['user_id'] = current_user.id
    params['job']['post_date'] = DateTime.now

    @job = Job.new(job_params)

    if @job.save!
      redirect_to @job
    else
      render 'new'
    end
  end

  def show
    @job = Job.find_by(id: params[:id])
  end

  def destroy
    @job = Job.find_by(id: params[:id])
    
    if current_user.id == @job.user.id then 
      @job.destroy
      redirect_to :jobs
    end
  end

  def job_params 
    params.require(:job).permit(:user_id, :title, :description, :company, :url, :remote_options, :post_date)
  end 

end