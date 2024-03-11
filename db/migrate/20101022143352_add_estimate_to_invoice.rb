class AddEstimateToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :estimate, :boolean, :default => true
    
    for invoice in Invoice.find(:all, :conditions => "paid is not null")
      invoice.update_attribute(:estimate, false)
    end
    
  end

  def self.down
    remove_column :invoices, :estimate
  end
end
