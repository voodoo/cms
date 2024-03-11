class AddNoteToInvoiceItems < ActiveRecord::Migration
  def self.up
    add_column :invoice_items, :note, :string
  end

  def self.down
    remove_column :invoice_items, :note
  end
end
