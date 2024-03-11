class Mblz::ProductInvoicesController < MblzController
  before_filter :set_product_invoice, :except => [:index]
  before_filter :set_track_activity, only: [:update,  :destroy]

	def index
		@product_invoices = current_site.product_invoices.page(params[:page])
    
	end

  def new
    @product_invoice = current_site.product_invoices.new(
            mblz_commission: current_site.mblz_commission, 
            sales_commission: current_site.sales_commission)
  end

  
  def show

  end

  def print

    render layout: 'bs4'
    
  end

  def create
    if params[:product_invoice_item].nil?
      redirect_to({action: 'new'}, notice: "No Line items were selected")
      return
    end

    @product_invoice = current_site.product_invoices.create(product_invoice_params.merge(user_id: current_user.id))
    @product_invoice.create_items product_invoice_item_params
    track_activity @product_invoice
    redirect_to mblz_product_invoice_path(@product_invoice), :notice => "Product Invoice Created"

  end


  def update
    @product_invoice.product_invoice_items.destroy_all
    @product_invoice.create_items product_invoice_item_params
    @product_invoice.update_attributes(product_invoice_params)
    @product_invoice.reload
    #track_activity @product_invoice
    flash.now[:notice] = "Product Invoice Updated"   
    render :action => 'show' 
  end  

  def destroy
    @product_invoice.destroy
    redirect_to mblz_product_invoices_path, notice: "Product Invoice Destroyed"
  end  

  # 

  def product_invoice_item_params
    params.require(:product_invoice_item).map do |ii|
      ActionController::Parameters.new(ii.to_hash).permit!
    end


  end

  def item
    product_atts = {}
    if product_id =  params[:product_id]
      product = item = current_site.products.find(product_id)
      product_atts[:product_id] = product_id
      product_atts[:price] = product.price
    end
      
    render :partial => 'item', :layout => false, :locals => {:item => ProductInvoiceItem.new(product_atts)}
  end

  def set_product_invoice
    @product_invoice = current_site.product_invoices.find(params[:id]) if params[:id]
  end  

  def product_invoice_params
    # FUGLY ... mysql is ... confusing. Why not except default?
    [:tax_rate, :sales_commission, :mblz_commission].each do |f|
      params[:product_invoice][f] = params[:product_invoice][f].to_f
    end
    
    params.require(:product_invoice).permit!
  end

  def set_track_activity
    track_activity(@product_invoice)
  end
end