class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_action :authenticate, :only => [:create ]

  def create
    user = User.new(params[:user].permit!)
    if user.save
      render json: user.as_json(auth_token: user.authentication_token, email: user.email), status: 201
      return
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end

end
