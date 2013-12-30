class Transfer < ActiveRecord::Base
  has_many :transfer_line_items, dependent: :destroy
  accepts_nested_attributes_for :transfer_line_items

  validates :transferred_at, presence: true
  attr_accessor :from_category_id, :from_location_id
  
  validate :should_have_a_debit
  validates :balance, numericality: {equal_to: 0}

  #callbacks
  after_initialize do
    self.transferred_at ||= Time.zone.now
  end
  
  before_save do
    debit.gross_weight = 0 - credits.map(&:gross_weight).inject(0, &:+)
  end
  
  #methods
  def debit
    transfer_line_items.select{|t| t.gross_weight < 0}.first
  end
  
  def credits
    transfer_line_items.select{|t| t.gross_weight >= 0}
  end  
  
  def balance
    transfer_line_items.map(&:net_weight).inject(:+)
  end
  
  def balance!
    unless transfer_line_items.empty?
      transfer_line_items.each &:balance!
      debit.gross_weight = - credits.map(&:net_weight).inject(:+) - debit.container.empty_weight
      debit.balance!
    end
  end
  
  # Validations
  def should_have_a_debit
    if debit.nil?
      errors.add(:transfer_line_items, "There must be a Transfer Line Item with weight < 0.")
    end
  end
end
