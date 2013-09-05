# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    distance_multiplier 1.5
    first_name "max"
    last_name "max"
    user
  end
end
