class CreateInvoiceItems < ActiveRecord::Migration
  def self.up
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.integer :invoice_item_default_id
      t.integer :position
      t.string :name
      t.integer :qty
      t.decimal :price, :precision => 10, :scale => 2, :default => 0.0
      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_items
  end
end
