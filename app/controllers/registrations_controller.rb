class RegistrationsController < Devise::RegistrationsController
  
    private
  
    def sign_up_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
    end
  
    def account_update_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation, :current_password, :slackhandle, :career_status, :location, :max_distance, :will_relocate, :will_remote, :preferred_languages, :resume, :linkedin, :github )
    end

    def after_update_path_for(resource)
      careers_path()
    end
  end