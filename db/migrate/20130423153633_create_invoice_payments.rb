class CreateInvoicePayments < ActiveRecord::Migration
  def change

    create_table :invoice_payments do |t|
      t.integer :user_id
      t.integer :invoice_id
      t.integer :invoice_payment_type_id
      t.string :note
      t.timestamps
    end

    create_table :invoice_payment_types do |t|
      t.string :name
      t.timestamps
    end 

    %w{Check Paypal Other}.each do |name|
      InvoicePaymentType.create!(:name => name)
    end 

    add_column :sites, :paypal_email, :string  
    add_column :sites, :paypal, :boolean  

  end
end
