class AddReceivedBySiteOwnerToInvoice < ActiveRecord::Migration
  def change
  	add_column :invoices, :received_by, :integer, default: nil
  end
end
