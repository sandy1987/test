class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

    def after_sign_in_path_for(resource)
      profile = resource.profile
      if profile.is_completed?
        root_path
      else
        edit_profile_path(profile)
      end
    end

    def configure_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :username])
    end

end
