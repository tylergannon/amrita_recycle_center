# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    category nil
    location nil
    slug "MyString"
    incoming false
  end
end
