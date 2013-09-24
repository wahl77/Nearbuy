# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community do
    owner nil
    name "MyString"
    community_member nil
    community_moderator nil
  end
end
