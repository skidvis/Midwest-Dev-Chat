class CareersController < ApplicationController
    def index
       @devs = User.where("users.career_status IS NOT NULL AND users.career_status != 'Unavailable'").order('id DESC').limit(5)
    end

    def all_devs
        @devs = User.where("users.career_status IS NOT NULL AND users.career_status != 'Unavailable'").order('id DESC')
    end
end