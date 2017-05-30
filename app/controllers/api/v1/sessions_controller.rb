class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate, :only => [:create ]

  def create
    resource = User.find_for_database_authentication(login: params[:user][:login])
    if resource.nil?
      render :json=> { success: false, message: "Error with your login or password"}, :status=>401
    end

    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json=> { success: true, auth_token: resource.authentication_token, login: resource.login, email: resource.email }
    else
      render :json=> { success: false, message: "Error with your login or password" }, status: 401
    end
  end

  def destroy
  end

end
