require 'spec_helper'

describe Country do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "can be created only if it has a name" do
    @country = Country.create()
    expect(@country.valid?).to be_false
    @country = Country.create(name: "USA")
    expect(@country.valid?).to be_true
  end
end
