# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    number_and_street "MyString"
    city "MyString"
    state "MyString"
    zip_code "MyString"
    name "MyString"
    country nil
    latitude 1.5
    longitude 1.5
    gmaps false
  end
end
