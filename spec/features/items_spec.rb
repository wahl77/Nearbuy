require 'spec_helper'

describe "items" do
  before do 
    @user = FactoryGirl.create(:user)
    @item = FactoryGirl.create(:item, {user: @user})
    @item2 = FactoryGirl.create(:item)
    login(@user)
  end

  it "can be edited only if I own it" do
    visit item_path(@item)
    sleep 5
    expect(page).to have_link "Edit"
    expect(page).to have_content @item.name
    click_link "Edit"
    fill_in "standard_item_name", with: "Helloi"
    click_button "Submit"
    expect(page).to have_content "Helloi"
    visit item_path(@item2)
    expect(page).not_to have_link "Edit"
    expect(page).to have_content @item2.name
  end

end
