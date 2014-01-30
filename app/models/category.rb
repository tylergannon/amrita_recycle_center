class Category < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :default_container, class_name: 'Container', foreign_key: 'default_container_id'
  
  validates :default_container, presence: true

  extend FriendlyId  
  friendly_id :friendly_name, use: :slugged
  
  def friendly_name
    name.downcase.gsub(/[ -]/, '_') if name
  end
  
  def default_container_friendly_id=(friendly_id)
    self.default_container = Container.friendly.find(friendly_id)
  end
end
