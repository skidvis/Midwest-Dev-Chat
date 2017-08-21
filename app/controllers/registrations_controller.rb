class RegistrationsController < Devise::RegistrationsController
  
    private
  
    def sign_up_params
      params.require(:user).permit(:fullname, :slackhandle,:email, :password, :password_confirmation, :provider, :uid)
    end
  
    def account_update_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation, :current_password, :slackhandle, :career_status, :location, :max_distance, :will_relocate, :will_remote, :preferred_languages, :resume, :linkedin, :github )
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      careers_path()
    end
end