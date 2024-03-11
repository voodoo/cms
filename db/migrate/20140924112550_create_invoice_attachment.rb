class CreateInvoiceAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :site_id
      t.integer :invoice_id
      t.string :title
      t.boolean :before_or_after
      t.string  :image_file_name
      t.string  :image_content_type
      t.string  :image_file_size
      # t.string  :image_updated_at      
      t.timestamps
    end 
  end
end
