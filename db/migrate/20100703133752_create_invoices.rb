class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :site_id
      t.integer :contact_id
      t.datetime :paid
      t.datetime :sent_to_contact
      t.string :token
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
