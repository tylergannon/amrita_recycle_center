class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.decimal :capacity, precision: 7, scale: 2
      t.decimal :empty_weight, precision: 7, scale: 2

      t.timestamps
    end
  end
end
