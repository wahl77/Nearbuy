module SessionMacro
  def login(user)
    visit root_path
    click_link "Login"
    fill_in "email", with: user.email
    fill_in "password", with: "a"
    within("#login_modal") do 
      click_button "Login"
    end
  end

  def simulate_location(lat, lng)
    page.driver.browser.execute_script <<-JS
      window.navigator.geolocation.getCurrentPosition = function(success){
        var position = {"coords" : { "latitude": "#{lat}", "longitude": "#{lng}" }};
      }
    JS
  end 
end
