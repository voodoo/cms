class Mblz::ProductInventoriesController < MblzController

  def current
    @products = current_site.products
  end
  
  def index
  	@product_inventories = current_site.product_inventories
  end

  def new
  	@product_inventory = current_site.product_inventories.build
  	@products = current_site.products
  end

  def show
    @product_inventory = current_site.product_inventories.find(params[:id])
  end

  def sales
    @products = current_site.products
  end

  def problems
    @problems = ProductInventory.product_values(current_site)[3]
  end

  def create
    create_new = []
    params[:product_inventory].each do |pi|
      # if submitting blank fields
      pi[:actual]    = pi[:actual].to_i
      pi[:projected] = pi[:projected].to_i

      if pi[:actual] != pi[:projected]
        create_new.push pi
      end
    end
    unless create_new.size.zero?
      pi = current_site.product_inventories.create(note: params[:note], user_id: current_user.id)
      create_new.each do |cn|
        pi.product_inventory_items.create(product_id: cn[:product_id], :actual_count => cn[:actual], :projected_count => cn[:projected])
        # Update the product shadow inventory count
        product = current_site.products.find(cn[:product_id]).update_attribute(:inventory, cn[:actual])
      end
    end
  	redirect_to mblz_product_inventories_path, notice: "Inventory created"
  end

end
