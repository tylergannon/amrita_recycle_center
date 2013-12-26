class CreateTransferLineItems < ActiveRecord::Migration
  def change
    create_table :transfer_line_items do |t|
      t.boolean :credit
      t.references :account, index: true
      t.references :container, index: true
      t.decimal :gross_weight
      t.decimal :net_weight

      t.timestamps
    end
  end
end
