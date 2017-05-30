class Api::V1::ProfilesController < Api::V1::ApiController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def show
  end

  def update
    if @profile.update(profile_params)
      render :json=> @profile.as_json(msg: 'Profile was successfully updated.')
    else
      render :edit
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:name, :company, :position, :phone, :home_address, :security_question, :security_answer, :image)
    end

    def set_profile
      @profile = current_user.profile
    end

end
