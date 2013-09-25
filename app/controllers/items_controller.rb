class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :find_address, only:[:search, :show]

  skip_before_action :require_login, only:[:show, :search]

  def index
    @addresses = current_user.addresses.map{|address| address unless address.items.empty?}.compact
    @items = current_user.items
  end

  def show
  end

  def new
    @item = current_user.items.build
    @addres = @item.build_address
  end

  def edit
    authorize! :update, @item
  end

  def create
    if params[:item][:address_id]
      @item = current_user.items.build(item_params)
    else
      @item = current_user.items.build(item_with_address_params)
      current_user.addresses << @item.address if (@item.address && @item.address.valid?)
      @item.address = @item.address
    end
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html {
          @addres = @item.build_address

          render action: 'new'
        }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @item
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @item
    @item.destroy
    redirect_to items_path
  end

  def search
    # @address already set by find_address
    @categories = params[:categories].split(",") unless params[:categories].nil?
    @query = params[:query]
    @range = params[:range] ? params[:range].to_f : RANGE_CONSTANT
    @range = @range * current_user.profile.distance_multiplier if current_user

    @items = (params[:query] && !params[:query].blank?) ? Item.item_search(@query, @address, @range, @categories).results : Item.near(@address, @range, @categories).includes(:user, :address, :images)

    @items = @items.sample(4) unless current_user
    respond_to do |format|
      format.html{
        render template: "static_pages/index"
      }
      format.json{
        render json: @items.map{|item| {id: item.id, name: item.name, description: item.description, image: item.images.empty? ? nil : item.images.first.url }}
        }
      format.js{

        render layout: false

      }
    end
  end

  private
    def find_address
      @address = params[:address] && !params[:address][:latitude].blank? ? Address.new(address_params) : user_current_location
    end

    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :address_id, images_attributes:[:url], :category_ids => [])
    end
    def item_with_address_params
      params.require(:item).permit(:name, :description, :address_id, images_attributes:[:url], address_attributes:[:name, :number_and_street, :city, :zip_code, :country_id, :state], :category_ids => [])
    end
    def address_params
      params.require(:address).permit(:latitude, :longitude)
    end

    def address_params
      params.require(:address).permit(:latitude, :longitude)
    end
end
