class AddDefaultContainerToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :default_container_id, :integer, index: true
  end
end
