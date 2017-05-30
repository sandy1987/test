class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json
  before_action :authenticate

  def index
    episodes = Episode.all
    render json: episodes, status: 200
  end

  protected

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end

end
