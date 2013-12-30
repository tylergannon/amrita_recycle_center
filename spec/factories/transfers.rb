# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transfer do

  end
  
  factory :balanced_transfer, parent: :transfer do
    ignore do
      container nil
    end
    
    after :build do |transfer, evaluator|
      if transfer.transfer_line_items.empty?
        @container = evaluator.container || create(:container)
      
        transfer.transfer_line_items << build( :transfer_line_item, 
                                        container: @container, 
                                        gross_weight: -13, 
                                        net_weight: (-13 + @container.empty_weight))

        transfer.transfer_line_items << (build :transfer_line_item, 
                                        container: @container, 
                                        gross_weight: 13, 
                                        net_weight: (13 - @container.empty_weight))

      end

      transfer.balance!
    end
  end
end
