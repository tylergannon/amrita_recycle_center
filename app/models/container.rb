class Container < ActiveRecord::Base
  NO_CONTAINER_NAME = 'No Container (N/A)'
  def self.no_container
    find_by(name: NO_CONTAINER_NAME)
  end
end
