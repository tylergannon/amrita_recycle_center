# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transfer do

  end
  
  factory :balanced_transfer, parent: :transfer do
    ignore do
      container nil
      account nil
    end
    
    after :build do |transfer, evaluator|
      transfer.debit.account = evaluator.account || create(:account)
      if transfer.credits.empty?
        @container = evaluator.container || create(:container)

        transfer.transfer_line_items.build  container: @container,
                                            gross_weight: 13,
                                            account: create(:account)

      end

      transfer.balance!
    end
  end
end
