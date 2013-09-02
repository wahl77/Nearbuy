# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    number_and_street "414 Brannan Street"
    city "San Francisco"
    state "CA"
    zip_code "94107"
    name "SF"
    country 
    latitude 1.5
    longitude 1.5
    gmaps false
  end
end
