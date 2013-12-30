# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transfer_line_item do
    gross_weight 12
    net_weight 10
    container
    
    # credit false
    # account nil
    # container nil
    # gross_weight "9.99"
    # net_weight "9.99"
  end
  
  factory :balanced_transfer_line_item, parent: :transfer_line_item do
    after :build do |line_item, evaluator|
      line_item.balance!
    end
  end
end
