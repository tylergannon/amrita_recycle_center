class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug, index: true, unique: true

      t.timestamps
    end
  end
end
