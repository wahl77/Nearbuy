# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community_moderator do
    community nil
    user nil
  end
end
