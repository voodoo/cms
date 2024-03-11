class ProductInventoryItem < ActiveRecord::Base
  belongs_to :product_inventory
  belongs_to :product
end