# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    distance_multiplier 1.5
    user nil
  end
end
