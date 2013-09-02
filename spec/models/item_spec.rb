require 'spec_helper'

describe Item do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "won't work without an address" do 
    @item = Item.create(name: "OK", description: "balH")
    expect(Item.all.include? @item).to be_false
  end

  it "can be created" do 
    @address = FactoryGirl.create(:address)
    @item = Item.create(name:"some_item", address: @address)
    expect(@item.valid?).to be_true
  end

end
