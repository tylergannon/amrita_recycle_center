class TransferLineItem < ActiveRecord::Base
  belongs_to :account
  belongs_to :container
  belongs_to :transfer
  
  validate :net_weight_should_be_the_difference_between_gross_weight_and_container_weight
  
  def net_weight_should_be_the_difference_between_gross_weight_and_container_weight
    unless net_weight == gross_weight - container.empty_weight
      errors.add(:net_weight, "Should be difference between gross weight and container weight")
    end
  end
end
