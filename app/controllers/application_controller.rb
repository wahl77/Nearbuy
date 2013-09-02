class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, :create_menu_variables

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), alert: "Message: #{exception.message}"
  end


  def create_menu_variables
    @form_item = Item.new
    @form_address = @form_item.build_address
    @form_image = @form_item.images.build
  end

  protected
    def not_authenticated
      redirect_to root_path, :alert => "Please login first."
    end

    def user_current_location
      # For an HTTP request do the following
      ip = Geocoder.search("#{request.ip}") unless cookies[:location]

      if cookies[:location]
        address = Address.new(eval(cookies[:location]))
      else
        address = Address.new(latitude: ip.first.latitude, longitude: ip.first.longitude)
        if Rails.env.development?
          #address = Address.new(latitude: 37.78257, longitude: -122.3899269)# SF
          address = Address.new(latitude: 46.1983922, longitude: 6.142296099999999)# Geneva
        end
      end

      return address
    end
end
