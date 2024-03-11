class AddUserAndClientToProdInv < ActiveRecord::Migration
  def change
  	add_column :product_invoices, :contact_id, :integer
  	add_column :product_invoices, :mblz_commission, :decimal, :precision => 10, :scale => 2, :default => 0.0, null: false
  	add_column :product_invoices, :sales_commission, :decimal, :precision => 10, :scale => 2, :default => 0.0, null: false

  	add_column :product_invoices, :tax_rate, :decimal, :precision => 10, :scale => 2, :default => 0.08125, null: false

  	add_column :sites, :mblz_commission, :decimal, :precision => 10, :scale => 2, :default => 0.0, null: false
  	add_column :sites, :sales_commission, :decimal, :precision => 10, :scale => 2, :default => 0.0, null: false  	
  end
end
