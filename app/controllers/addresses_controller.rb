class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def create
    @address = current_user.addresses.build(address_params) 
    respond_to do |format|
      if @address.save
        format.html { redirect_to user_path(current_user), notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end 
  end

  def destroy
    authorize! :destroy, @address
    @address.destroy
    redirect_to user_path(current_user)
  end


  def update_geolocation
    cookies[:location] = {value: {latitude: params[:location][:latitude], longitude: params[:location][:longitude]}, expires: 1.hour.from_now}
    respond_to do |format|
      format.all { head :ok, content_type: "text/html" }
    end
  end
  
  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:name, :number_and_street, :city, :zip_code, :country_id, :state)
    end
end
