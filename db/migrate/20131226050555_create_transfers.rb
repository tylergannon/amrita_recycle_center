class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.datetime :transferred_at

      t.timestamps
    end
  end
end
