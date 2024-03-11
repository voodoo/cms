class AddCostPricingToProducts < ActiveRecord::Migration
  def change
  	change_column :product_invoices, :tax_rate, :decimal, :precision => 10, :scale => 4, :default => 0.0825, null: false
  	add_column :products, :cost, :decimal, :precision => 10, :scale => 2, :default => 0.00, null: false
  	add_column :products, :markup, :decimal, :precision => 10, :scale => 2, :default => 2, null: false
  end
end
