class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
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
