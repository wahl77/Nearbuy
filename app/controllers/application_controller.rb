class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, :create_menu_variables

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), alert: "Message: #{exception.message}"
  end


  protected
    def distance_multiplier
      return current_user ? current_user.profile.distance_multiplier : 1
    end
    helper_method :distance_multiplier

    def not_authenticated
      redirect_to root_path, :alert => "Please login first."
    end

    # This function just set-up the navigation form 
    # with variable that will be used on every page
    def create_menu_variables
      @form_item = Item.new
      @form_address = @form_item.build_address
      @form_image = @form_item.images.build
    end

    # This methods get either geolocation information 
    # if the user has a cookie. Otherwise, it tries to
    # get the information from ip data
    def user_current_location

      if cookies[:position]
        # If cookies are set, use information from cookie
        address = Address.new(eval(cookies[:position]))
      else
        # For an HTTP request do the following
        # If no cookies, try to aquire location from ip
        ip = Geocoder.search("#{request.ip}")
        address = Address.new(latitude: ip.first.latitude, longitude: ip.first.longitude)
        if Rails.env.development?
          #address = Address.new(latitude: 37.78257, longitude: -122.3899269)# SF
          address = Address.new(latitude: 46.1983922, longitude: 6.142296099999999)# Geneva
        end
      end

      return address
    end
end
