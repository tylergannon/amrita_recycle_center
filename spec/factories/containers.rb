# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :container do
    name
    empty_weight 1
    capacity 1
  end
end
