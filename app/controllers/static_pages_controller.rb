class StaticPagesController < ApplicationController
  skip_before_action :require_login, only:[:index]

  def index
    @ip = Geocoder.search("#{request.ip}")
    @address = Address.new(latitude: @ip.first.latitude, longitude: @ip.first.longitude)
    if Rails.env.development?
      @address = Address.new(latitude: 37.78257, longitude: -122.3899269)# SF
      @address = Address.new(latitude: 46.1983922, longitude: 6.142296099999999)# Geneva
    end
    @items = Item.near(@address, 2)
  end

  def about
  end
end
