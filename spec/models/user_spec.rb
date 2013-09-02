require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "can be created" do
    @user = User.create(email: "b@a.com")
    expect(@user.valid?).to be_false
    @user = User.create(email: "b@a.com", password:"a")
    expect(@user.valid?).to be_true
    @user = FactoryGirl.create(:user)
    expect(@user.valid?).to be_true
  end
end
