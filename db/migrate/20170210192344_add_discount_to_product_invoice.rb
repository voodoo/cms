class AddDiscountToProductInvoice < ActiveRecord::Migration
  def change
  	add_column :product_invoices, :discount, :decimal, :precision => 10, :scale => 2, :default => 0.0  
  end
end
