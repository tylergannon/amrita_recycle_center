class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug, index: true, unique: true

      t.timestamps
    end
  end
end
