class Api::V1::PasswordsController < Api::V1::ApiController
  skip_before_action :authenticate, :only => [:create ]

  def create
    resource = User.find_for_database_authentication(login: params[:user][:login])
    if resource.nil?
      render json: { success: false, message: "No such Email or Username present in our database!" }, status: 401
    else
      resource.send_reset_password_instructions
      render json: { success: true, message: t('devise.passwords.send_instructions') }
    end
  end

end
