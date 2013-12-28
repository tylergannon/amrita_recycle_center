class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.datetime :transferred_at
      t.integer :source_account_id, index: true

      t.timestamps
    end
  end
end
