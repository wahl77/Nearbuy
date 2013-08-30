class SessionsController < ApplicationController
  skip_before_action :require_login, only:[:new, :create, :destroy]
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to user_path(user), notice:"Logged in successfully!"
    else
      flash.now[:alert] = "Sorry, email or password incorrect"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice:"Logged Out"
  end
end
