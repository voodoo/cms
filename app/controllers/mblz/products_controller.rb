class Mblz::ProductsController < MblzController
  before_filter :set_cors_products_index, :only => [:index]
  before_filter :set_product,:except => [:index]
  skip_before_filter :has_permission?, only: :index
  skip_before_filter :require_user, only: :index
  skip_before_filter :verify_authenticity_token, only: :index  

  def sales
    @details = ProductInventory.details_for(current_site, @product)
  end


	def index
		@products = current_site.products
    if request.format != 'html'
      @products = @products.where("inventory > 0 and inactive = false").map{|p| p.attributes.merge!(image_thumb_path: p.image.url(:thumb), category: p.product_category.name)}
      render json: @products
    end
	end

	def update
    if @product.update_attributes(product_params)
      redirect_to mblz_product_path(@product), notice: "Product Updated"
    else
      flash[:notice] = 'Please fix data error'
      render action: 'edit'
    end		
	end

  def new
    @product = current_site.products.new(product_category_id: 1)
  end

  def create
    @product = current_site.products.new(product_params)
    if @product.save
      redirect_to mblz_product_path(@product), notice: "Product Created"
    else
      render action: :new
    end
  end

  def destroy
    if @product.product_invoice_items.present?
      flash[:notice] = 'Can not delete product attached to invoice item'
      render action: 'edit'
      return
    end
    @product.destroy
    redirect_to mblz_products_path, notice: "Product Destroyed"
  end  

  def upload_image
    @product.update_attributes(image: params[:image], image_file_name: params[:name])
    render nothing: true
  end

private

def set_cors_products_index
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  headers['Access-Control-Request-Method'] = '*'
  headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
end

  def set_product
    @product = current_site.products.find(params[:id]) if params[:id]
  end 	


  def product_params
    # FUGLY ... mysql is ... confusing. Why not except default?
    [:cost, :markup].each do |f|
      params[:product][f] = params[:product][f].to_f
    end    
  	params.require(:product).permit! 
  end
end
