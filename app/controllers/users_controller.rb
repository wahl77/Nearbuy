class UsersController < ApplicationController
  skip_before_action :require_login, only:[:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @address = Address.new #current_user.addresses.build
  end

  def new
    @user = User.new
  end

  def edit
    authorize! :update, @user
    @user.build_image if @user.image.nil?
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save 
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_profile_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end 
    end 
  end

  def destroy
    authorize! :destroy, @user
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end 
  
    def user_profile_params
      params.require(:user).permit(:first_name, :last_name, addresses_attributes:[:name, :number_and_street, :city, :zip_code, :country_id, :_destroy], image_attributes:[:url])
    end
end
