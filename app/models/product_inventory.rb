class ProductInventory < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :product_inventory_items

  def self.product_details site
    retail              = 0.00
    cost                = 0.00
    number_of_products  = 0
    not_costed          = []
    negative_inventory  = []
    inactive            = []

    site.products.each do |product|
      if product.inactive?
        inactive.push product 
      elsif not product.inventory.to_i > -1
        negative_inventory.push product
      elsif product.cost.zero? or product.price.zero?
        not_costed.push product
      else
        retail              += product.inventory * product.price
        cost                += product.inventory * product.cost
        number_of_products  += product.inventory
      end
    end

    [number_of_products, retail, cost, not_costed, negative_inventory, inactive]

  end

  def self.details_for site, product
    returned = {}
  	last_inventory                   = last_inventory_for(site, product)
    if last_inventory 
      returned[:last_inventory] = last_inventory
      returned[:last_inventory_date] = last_inventory.created_at
      returned[:product_count]       = last_inventory.product_inventory_items.where(product_id: product.id).first.actual_count
      returned[:sold]                = products_sold_since(site, product, last_inventory.created_at)
      returned[:projected_count]     = returned[:product_count] - returned[:sold] 
      returned[:product_invoices]    = product_invoices_with_product(site, product, last_inventory.created_at)
    else
      returned[:last_inventory_date] = nil
      returned[:product_count]       = 0
      returned[:sold]                = products_sold_since(site, product, nil)
      returned[:projected_count]     = returned[:product_count] - returned[:sold]       
      returned[:product_invoices]    = product_invoices_with_product(site, product)
    end
  	returned
  end

  def self.products_sold_since site, product, last_inventory_date
    if last_inventory_date
  	 site.product_invoices.includes(:product_invoice_items).where("product_invoices.created_at > ? and product_id = ?", last_inventory_date, product.id ).pluck(:qty).sum
    else
      site.product_invoices.includes(:product_invoice_items).where("product_id = ?", product.id ).pluck(:qty).sum
    end
  end


  def self.product_invoices_with_product site, product, last_inventory_date = nil
    if last_inventory_date
     site.product_invoices.joins(:product_invoice_items).where("product_invoices.created_at > ? and product_invoice_items.product_id = ?", last_inventory_date, product.id )
    else
      site.product_invoices.joins(:product_invoice_items).where("product_invoice_items.product_id = ?", product.id )
    end
  end

  def self.last_inventory_for site, product
  	site.product_inventories.joins(:product_inventory_items).where("product_inventory_items.product_id = #{product.id}").limit(1).order(created_at: :desc).first
  end
end