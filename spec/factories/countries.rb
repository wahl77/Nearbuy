# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    sequence :name do |n|
        "Country#{n}"
    end
  end
end
