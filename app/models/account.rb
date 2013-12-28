class Account < ActiveRecord::Base
  belongs_to :category
  belongs_to :location
  
  def name
    "#{category.name}@#{location.name}"
  end
end
