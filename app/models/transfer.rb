class Transfer < ActiveRecord::Base
  has_many :transfer_line_items, dependent: :destroy
  accepts_nested_attributes_for :transfer_line_items

  validates :transferred_at, presence: true
  attr_accessor :from_category_id, :from_location_id

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
end
