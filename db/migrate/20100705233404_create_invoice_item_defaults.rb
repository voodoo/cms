class CreateInvoiceItemDefaults < ActiveRecord::Migration
  def self.up
    create_table :invoice_item_defaults do |t|
      t.string :name
      t.integer :qty
      t.decimal :price, :precision => 10, :scale => 2, :default => 0.0
      t.timestamps
    end    
    remove_column :invoice_items, :name
    add_column :invoice_items, :invoice_item_default_id, :integer
  end

  def self.down
    add_column :invoice_items, :name, :string
    remove_column :invoice_items, :invoice_item_default_id
    drop_table :invoice_item_defaults
  end
end
