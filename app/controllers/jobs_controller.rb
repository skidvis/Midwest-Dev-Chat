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

  def edit    
    @job = Job.friendly.find(params[:id])
  end

  def update
    @job = Job.friendly.find(params[:id])
    @job.post_date = DateTime.now

    if @job.update_attributes(job_params)
      redirect_to @job
    else
      flash[:notice] = @job.errors.messages.to_a.join(' ')
      render 'edit'
    end
  end

  def show
    @job = Job.friendly.find(params[:id])
  end

  def destroy
    @job = Job.friendly.find(params[:id])
    
    if current_user.id == @job.user.id then 
      @job.destroy
      redirect_to :jobs
    end
  end

  def job_params 
    params.require(:job).permit(:user_id, :title, :description, :company, :url, :remote_options, :post_date)
  end 

end