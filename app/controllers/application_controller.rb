class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  acts_as_token_authentication_handler_for User

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def index;end

  protected

    def configure_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,        keys: [:email, :password, :password_confirmation, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :username])
    end
end
