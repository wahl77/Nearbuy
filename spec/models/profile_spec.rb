require 'spec_helper'

describe Profile do
  it "can be created" do 
    profile = FactoryGirl.create(:profile)
    expect(profile.valid?).to be_true
  end
end
