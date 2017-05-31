class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json
  before_action :authenticate

  def current_user
    User.find_by(authentication_token: request.headers.env['HTTP_AUTH_TOKEN'])
  end

  def landing_page_detail_for_loggedin_user
    if current_user.is_admin?
      { incomplete_profile: false, role: 'admin', all_schedules: WorkSchedule.all }
    else
      { incomplete_profile: false, role: 'user', next_schedule: current_user.work_schedules.where("start_date >= ?", Time.now.to_date).first }
    end
  end

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      User.find_by(authentication_token: request.headers.env['HTTP_AUTH_TOKEN'])
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end

end
