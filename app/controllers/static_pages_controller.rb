class StaticPagesController < ApplicationController
  skip_before_action :require_login, only:[:index, :about]

  def index
    @address = user_current_location
    @items = Item.near(@address, RANGE_CONSTANT).includes(:address, :user).sample(4).shuffle
  end

  def about
  end
end
