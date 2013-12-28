class Transfer < ActiveRecord::Base
  has_many :transfer_line_items, dependent: :destroy do
    def debit
      proxy_association.target.first
    end
    def credit
      proxy_association.target.select{|t| t.gross_weight >= 0}
    end
  end
  validates :transferred_at, presence: true
  
  accepts_nested_attributes_for :transfer_line_items
  
  after_initialize do
    self.transferred_at ||= Time.zone.now
  end
  
  attr_accessor :from_category_id, :from_location_id
end
