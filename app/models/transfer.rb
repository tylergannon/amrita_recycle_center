class Transfer < ActiveRecord::Base
  has_many :transfer_line_items, before_add: :truify_line_item_credit, dependent: :destroy do
    def debit
      where(credit: false)
    end
    def credit
      where(credit: true)
    end
  end
  accepts_nested_attributes_for :transfer_line_items

  validates :transferred_at, presence: true
  attr_accessor :from_category_id, :from_location_id
  
  validate :should_have_a_debit
  validates :balance, numericality: {equal_to: 0}
  
  attr_reader :debit

  #callbacks
  after_initialize do
    self.transferred_at ||= Time.zone.now
    if new_record?
      @debit = transfer_line_items.build(credit: false, container: Container.no_container)
    end
  end
  
  after_find do
    @debit = transfer_line_items.debit.first
  end
  
  # before_save do
  #   debit.gross_weight = 0 - credits.sum(:gross_weight)
  # end
  
  #methods
  
  def debit_attributes=(attrs)
    debit.attributes = attrs
  end
  
  def credits
    transfer_line_items.select{|t| t.credit}
  end  
  
  def balance
    transfer_line_items.each &:balance!
    transfer_line_items.map(&:net_weight).inject(:+)
  end
  
  def balance!
    return if credits.empty?
    transfer_line_items.each &:balance!
    foo = credits.map(&:net_weight)
    bar = - foo.inject(:+)
    debit.gross_weight = bar - debit.container.empty_weight
    debit.balance!
  end
  
  private
  
  # Validations
  def should_have_a_debit
    if debit.nil?
      errors.add(:transfer_line_items, "There must be a Transfer Line Item with weight < 0.")
    end
  end
  
  def truify_line_item_credit(line_item)
    line_item.truify_credit!
  end
end
