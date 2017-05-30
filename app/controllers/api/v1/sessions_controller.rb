class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate, :only => [:create ]

  def create
    resource = User.find_for_database_authentication(login: params[:user][:login])
    if resource.nil?
      render :json=> { success: false, message: "Error with your login or password"}, :status=>401
    elsif resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      after_sign_in_page_data(resource)
      # render :json=> { success: true, auth_token: resource.authentication_token, login: resource.login, email: resource.email }
    else
      render :json=> { success: false, message: "Error with your login or password" }, status: 401
    end
  end

  def destroy
  end

  def after_sign_in_page_data(resource)
    profile = resource.profile
    if profile.is_completed?
      landing_page_for_loggedin_user
    else
      edit_profile_path(profile)
    end
  end

  private

    def landing_page_for_loggedin_user
      if current_user.is_admin?
        work_schedules_path
      else
        next_schedule_path
      end
    end


end
