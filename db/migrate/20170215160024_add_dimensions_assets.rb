class AddDimensionsAssets < ActiveRecord::Migration
  def change
  	add_column :products, :dimensions, :string
  	add_column :attachments, :dimensions, :string
  	change_column_null :product_invoices, :discount, false
  end
end
