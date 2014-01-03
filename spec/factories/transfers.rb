# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transfer do

  end
  
  factory :balanced_transfer, parent: :transfer do
    ignore do
      container nil
      location nil
      category nil
    end
    
    after :build do |transfer, evaluator|
      transfer.debit.category = evaluator.category || create(:category)
      transfer.debit.location = evaluator.category || create(:location)
      
      if transfer.credits.empty?
        @container = evaluator.container || create(:container)

        transfer.transfer_line_items.build  container: @container,
                                            gross_weight: 13,
                                            category: create(:category),
                                            location: create(:location)

      end

      transfer.balance!
    end
  end
end
