require 'spec_helper'

describe "static_pages/index.html.haml" do
  #pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "loads a blank page" do 
    visit logout_path
    visit root_path
    expect(page).to have_content "A great place"
  end

  it "can log in/out" do 
    visit logout_path
    expect(page).to have_content "Logged Out"
    visit root_path
    click_link "Login"
    fill_in "email", with: @user.email
    @user.password = "a"
    @user.save
    fill_in "password", with: "a"
    within("#login_modal") do 
      click_button "Login"
    end
    expect(page).to have_content "Logged in successfully!"
  end

end
