# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    sequence :name do |n|
        "Item#{n}"
    end
    description "MyString"
    user 
    address 
    after(:build) do |item|
      item.categories << FactoryGirl.create(:category)
    end
  end
end
