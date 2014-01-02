class Account < ActiveRecord::Base
  belongs_to :category
  belongs_to :location
  
  validates :category, presence: true
  validates :location, presence: true
  
  def name
    "#{category.name}@#{location.name}"
  end
  
  def find_by_category_and_location(category_name, location_name)
    category= Category.find_by(name: category_name)
    location = Location.find_by(name: location_name)
    account = find_by(category_id: category.id, location_id: location.id)
    unless account
      raise "Account not found: #{category_name} @ #{location_name}"
    else
      return account
    end
  end
end
