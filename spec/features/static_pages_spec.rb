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

  it "can sign up" do
    visit logout_path
    visit root_path
    click_link "Login"
    click_link "Signup"
    within("form#new_user") do
      fill_in "Email", with: "b@b.com"
      fill_in "Password", with: "ba$8903<#"
      fill_in "Password Confirmation", with: "ba$8903<#"
    end
    click_button "Signup"
    expect(page).to have_content "User was successfully created."
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

  describe "Check only authorized pages if not logged in" do
    before do
      visit logout_path
      @login_first = "Please login first"
    end
    it "cannot create new item" do 
      visit new_item_path
      expect(page).to have_content @login_first
    end

    it "can view an item but not post a comment" do
      item = FactoryGirl.create(:item)
      visit item_path(item)
      expect(page).to have_content item.name
      visit edit_item_path(item)
      expect(page).to have_content @login_first
    end
  end

end
