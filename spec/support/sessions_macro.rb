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
end
