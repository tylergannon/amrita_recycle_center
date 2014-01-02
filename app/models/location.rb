class Location < ActiveRecord::Base
  validates :name, presence: true
  
  extend FriendlyId  
  friendly_id :friendly_name, use: :slugged
  
  def friendly_name
    name.downcase.gsub(/[ -]/, '_') if name
  end
end
