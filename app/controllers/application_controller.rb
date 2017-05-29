class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def index;end

end
