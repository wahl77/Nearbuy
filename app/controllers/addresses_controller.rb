class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only:[:update_geolocation]


  def new
    @address = current_user.addresses.build 
  end

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

  def update
    authorize! :update, @address
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to user_path(current_user), notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @address.items.empty?
      authorize! :destroy, @address
      flash[:notice] = "Address successfully removed"
      @address.destroy
      redirect_to user_path(current_user)
    else
      flash[:notice] = "Please remove associated items first"
      @addresses = [@address]
      render template:"items/index"
    end
  end


  def update_geolocation
    cookies[:position] = {value: {latitude: params[:position][:latitude], longitude: params[:position][:longitude]}, expires: 1.hour.from_now}
    respond_to do |format|
      format.all { head :ok, content_type: "text/html" }
    end
  end
  
  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:name, :number_and_street, :city, :zip_code, :country_id, :state, :gmaps)
    end
end
