class StaticPagesController < ApplicationController
  skip_before_action :require_login, only:[:index]

  def index
    @address = user_current_location
    @items = Item.near(@address, 2)
  end

  def about
  end
end
