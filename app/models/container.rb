class Container < ActiveRecord::Base
  validates :name, presence: true
  validates :empty_weight, numericality: true
  validates :capacity, numericality: true
  
  NO_CONTAINER_NAME = 'No Container (N/A)'
  def self.no_container
    find_by(name: NO_CONTAINER_NAME)
  end
  
  def display_name
    "#{name} (#{capacity}L/#{empty_weight}Kgs)"
  end
  
  extend FriendlyId  
  friendly_id :friendly_name, use: :slugged
  
  def friendly_name
    name.downcase.gsub(/[ -]/, '_') if name
  end
end
