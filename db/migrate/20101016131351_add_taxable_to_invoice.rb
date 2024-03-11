class AddTaxableToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :taxable, :boolean, :default => true
  end

  def self.down
    remove_column :invoices, :taxable
  end
end
