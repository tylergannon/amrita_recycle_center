class CreateTransferLineItems < ActiveRecord::Migration
  def change
    create_table :transfer_line_items do |t|
      t.boolean :credit
      t.references :location, index: true
      t.references :category, index: true
      t.references :container, index: true
      t.references :transfer, index: true
      t.decimal :gross_weight, precision: 7, scale: 2
      t.decimal :net_weight, precision: 7, scale: 2
      t.string :notes

      t.timestamps
    end
  end
end
