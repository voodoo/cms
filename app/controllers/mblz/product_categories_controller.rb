class Mblz::ProductCategoriesController < MblzController
	before_filter :set_product_category
  skip_before_filter :has_permission?, only: :index
  skip_before_filter :require_user, only: :index
  skip_before_filter :verify_authenticity_token, only: :index  


	def index
		@categories = current_site.product_categories
    if request.format != 'html'
      render json: @categories
    end
	end

	def update
    if @product_category.update_attributes(product_params)
      redirect_to mblz_product_categories_path, notice: "Product Category Updated"
      flash[:notice] = 'Product updated'
    else
      flash[:notice] = 'Please fix data error'
      render action: 'edit'
    end		
	end

  def new
    @product = current_site.product_categories.new
  end

  def create
    product = current_site.product_categories.create(product_params)
    redirect_to mblz_products_path, notice: "Product Created"
  end

  def destroy
    @product_category.destroy
    redirect_to mblz_product_categories_path, notice: "Product Category Destroyed"
  end  

private

  def set_product_category
    @product_category = current_site.product_categories.find(params[:id]) if params[:id]
  end 	


  def product_params
  	params.require(:product_category).permit! 
  end
end
