class TransferLineItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :location
  belongs_to :container
  belongs_to :transfer
  
  before_validation :balance!, :truify_credit!
  
  validates :container, presence: true
  validates :gross_weight, numericality: true
  validates :net_weight, numericality: true
  
  validate :weight_should_only_be_negative_if_and_only_if_this_is_a_debit
  validate :net_weight_should_be_the_difference_between_gross_weight_and_container_weight
  
  def weight_should_only_be_negative_if_and_only_if_this_is_a_debit
    return unless gross_weight
    if gross_weight > 0 && debit?
      errors.add(:gross_weight, "Must be negative for debit transactions.")
    elsif gross_weight < 0 && credit?
      errors.add(:gross_weight, "Must be positive for credit transactions.")
    end
  end
  
  def credit?
    !!credit
  end
  
  def debit?
    credit == false
  end
  
  def net_weight_should_be_the_difference_between_gross_weight_and_container_weight
    if container && net_weight && gross_weight
      unless net_weight.abs == (gross_weight.abs - container.empty_weight)
        errors.add(:net_weight, "Should be difference between gross weight and container weight")
      end
    end
  end
  
  def balance!
    unless container.nil? || gross_weight.nil? || gross_weight.abs < container.empty_weight
      self.net_weight = gross_weight >= 0 ? (gross_weight - container.empty_weight) : (gross_weight + container.empty_weight)
    end
  end
  
  def truify_credit!
    self.credit = true unless credit == false
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
