class CreateInvoiceStatus < ActiveRecord::Migration
  # Accomodate for 'Cancelled' - now the first status
  def up
    create_table :invoice_statuses do |t|
      t.integer :invoice_id
      t.integer :user_id
      t.integer  :status
      t.datetime :created_at
    end 
    add_index :invoice_statuses, :invoice_id
    add_index :invoice_statuses, :user_id
    add_index :invoices, :site_id     
  end

  def down
    drop_table :invoice_statuses
    remove_index :invoices, :site_id     

  end

end
