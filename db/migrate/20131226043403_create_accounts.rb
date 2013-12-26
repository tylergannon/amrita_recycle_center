class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :category, index: true
      t.references :location, index: true
      t.string :slug, index: true
      t.boolean :incoming

      t.timestamps
    end
  end
end
