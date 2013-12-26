class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.decimal :capacity, precision: 6, scale: 2
      t.decimal :empty_weight, precision: 6, scale: 2

      t.timestamps
    end
  end
end
