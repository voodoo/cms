class Mblz::InvoiceItemDefaultsController < MblzController
  def index
    @dones = InvoiceItemDefault.that_are_empty(current_site.id)
    @items = current_site.invoice_items.select("count(1) counter, invoice_item_default_id").order("counter desc").group("invoice_item_default_id")
  end
  def new
    @invoice_item_default = current_site.invoice_item_defaults.new
  end
  def create
    @invoice_item_default = current_site.invoice_item_defaults.create(invoice_item_defaults_params)
    redirect_to :action => 'index', :notice => "Item Created"
  end  
  def show
    @item_default = current_site.invoice_item_defaults.find(params[:id])
  end
  def destroy
    @item_default = current_site.invoice_item_defaults.find(params[:id])
    @item_default.destroy
    redirect_to :action => 'index'
  end
  def update
    @item_default     = current_site.invoice_item_defaults.find(params[:id])
    for item in @item_default.invoice_items
      note = item.note.to_s + ' - ' + @item_default.name 
      puts "updating #{item.invoice_item_default_id} to #{params[:invoice_item_default]} and note to #{note}"
      item.update_attributes(:invoice_item_default_id => params[:invoice_item_default].to_i, :note => note) 
    end
    @new_item_default = current_site.invoice_item_defaults.find(params[:invoice_item_default])
    InvoiceItemDefault.clear_empty!(current_site.id)
  end

  private
  def invoice_item_defaults_params
    params.require(:invoice_item_default).permit!
  end
end