# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "String #{n}"
  end
  factory :category do
    name
    association :default_container, factory: :container
  end
end
