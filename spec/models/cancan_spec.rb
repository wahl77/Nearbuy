require 'spec_helper'

describe Ability do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has right ability" do 
    @user = FactoryGirl.create(:user)
    @ability = Ability.new(@user)
    expect(@ability.can?(:create, Item)).to be_true
  end
end
