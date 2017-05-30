class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate, :only => [:create ]

  def create
    resource = User.find_for_database_authentication(login: params[:user][:login])
    if resource.nil?
      render :json=> { success: false, message: "Error with your login or password"}, :status=>401
    elsif resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json=> { success: true, auth_token: resource.authentication_token, email: resource.email, data: after_sign_in_data(resource) }
    else
      render :json=> { success: false, message: "Error with your login or password" }, status: 401
    end
  end

  def destroy
  end

  def after_sign_in_data(resource)
    profile = resource.profile
    if profile.is_completed?
      landing_page_detail_for_loggedin_user
    else
      { incomplete_profile: true, profile: profile }
    end
  end

end
