class CareersController < ApplicationController
    def index
       @devs = User.where("users.career_status IS NOT NULL AND users.career_status != 'Unavailable'").order('id DESC').limit(5)
       @jobs = Job.all.order('post_date DESC').limit(5)
    end

    def all_devs
        @devs = User.where("users.career_status IS NOT NULL AND users.career_status != 'Unavailable'").order('id DESC')
    end

    def all_jobs
        @jobs = Job.all.order('post_date DESC')
    end    
end