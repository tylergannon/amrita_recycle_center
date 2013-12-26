class CreateTransferLineItems < ActiveRecord::Migration
  def change
    create_table :transfer_line_items do |t|
      t.boolean :credit
      t.references :account, index: true
      t.references :container, index: true
      t.decimal :gross_weight, precision: 6, scale: 2
      t.decimal :net_weight, precision: 6, scale: 2

      t.timestamps
    end
  end
end
