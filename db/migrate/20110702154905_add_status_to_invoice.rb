class AddStatusToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :status, :integer, :default => 0
    
    for invoice in Invoice.all
      status = 0
      if invoice.paid?
        status = Invoice.status_id('Paid')
      elsif !invoice.estimate?
        status = Invoice.status_id('Invoice')
      elsif invoice.estimate_confirmations.present?
        status = Invoice.status_id('Confirm')
      end
      invoice.update_attributes(:status => status) unless status == 0
    end
  end

  def self.down
   remove_column :invoices, :status    
  end
end
