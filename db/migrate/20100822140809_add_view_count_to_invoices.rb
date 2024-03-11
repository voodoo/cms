class AddViewCountToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :view_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :login
  end

end
