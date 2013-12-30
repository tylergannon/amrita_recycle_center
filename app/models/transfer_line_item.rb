class TransferLineItem < ActiveRecord::Base
  belongs_to :account
  belongs_to :container
  belongs_to :transfer
  
  before_validation :balance!
  
  validates :container, presence: true
  validates :gross_weight, numericality: true
  validates :net_weight, numericality: true
  
  validate :net_weight_should_be_the_difference_between_gross_weight_and_container_weight
  
  def net_weight_should_be_the_difference_between_gross_weight_and_container_weight
    if container && net_weight && gross_weight
      unless net_weight.abs == (gross_weight.abs - container.empty_weight)
        errors.add(:net_weight, "Should be difference between gross weight and container weight")
      end
    end
  end
  
  def balance!
    unless container.nil? || gross_weight.abs < container.empty_weight
      self.net_weight = gross_weight >= 0 ? (gross_weight - container.empty_weight) : (gross_weight + container.empty_weight)
    end
  end
  
  def balance
    unless container.nil? || gross_weight.abs < container.empty_weight
      net_weight - (gross_weight >= 0 ? (gross_weight - container.empty_weight) : (gross_weight + container.empty_weight))
    end
  end
  
  private
  def net_weight=(weight)
    super
  end
end
