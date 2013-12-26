# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :container do
    name "MyString"
    capacity "9.99"
    empty_weight "9.99"
  end
end
