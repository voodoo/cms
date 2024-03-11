class AddTextToInvoiceSite < ActiveRecord::Migration
  def self.up
    Invoice.destroy_all
    InvoiceItemDefault.destroy_all
    add_column :sites, :invoice_footer, :text
    add_column :invoices, :footer, :text
    add_column :invoice_item_defaults, :site_id, :integer
    add_column :invoice_items, :site_id, :integer
    add_column :users, :login, :string
  end

  def self.down
    remove_column :sites, :invoice_footer
    remove_column :invoices, :footer
    remove_column :invoice_item_defaults, :site_id
    remove_column :invoice_items, :site_id
    remove_column :users, :login
  end
end
