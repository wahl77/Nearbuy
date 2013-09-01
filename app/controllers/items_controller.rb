class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :find_address, only:[:get_sample, :around_me, :search]

  skip_before_action :require_login, only:[:get_sample, :show]

  def index
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

  def around_me
    if params[:categories].nil?
      @categories = Category.all.map{|x| x.id.to_s}
    else
      @categories = params[:categories].split(",")
    end 

    @address = user_current_location

    # Make a list of all items near you
    @items = Item.near(@address, 2)

    respond_to do |format|
      format.html 
      format.json { 
        @items = @items.map{|item| {id: item.id, name: item.name, description: item.description, image: item.images.empty? ? nil : item.images.first.url } if (item.categorizations.pluck(:category_id).map{|x| x.to_s} - @categories).size < item.categorizations.pluck(:category_id).map{|x| x.to_s}.size }.compact
        render json: @items.to_json 
      }
    end
  end

  def get_sample
    # @ address already set by find_address

    # Make a list of all items near you
    @items = Item.near(@address, 5).sample(5)

    respond_to do |format|
      format.html { 
        # This is the same as index page
        render template: "static_pages/index"
      }
      format.json { 
        # This is a list of JSON formated list containing item infor and image url
        render json: @items.map{|item| {id: item.id, name: item.name, description: item.description, image: item.images.empty? ? nil : item.images.first.url } }.to_json 
      }
      format.js {}
    end
  end


  def search
    # @ address already set by find_address
    @query = params[:query]
    @range = params[:range] || 10
    @items = Item.item_search(@query, @address, @range).results
  end

  private
    def find_address
      @address = params[:address] ? Address.new(address_params) : user_current_location
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
end
