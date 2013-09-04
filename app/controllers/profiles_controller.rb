class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  
  def edit
    authorize! :update, @profile
  end

  def update
    authorize! :update, @profile
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to current_user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end 
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :distance_multiplier)
    end
end
