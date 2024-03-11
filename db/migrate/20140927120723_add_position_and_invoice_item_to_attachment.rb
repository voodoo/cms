class AddPositionAndInvoiceItemToAttachment < ActiveRecord::Migration
  def change
  	add_column :attachments, :position, :integer
  	add_column :attachments, :invoice_item_id, :integer
  end
end
