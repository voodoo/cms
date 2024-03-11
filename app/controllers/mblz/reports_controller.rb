class Mblz::ReportsController < MblzController
  before_filter :set_calls, :except => [:sales]
  def index
    @grouped = @calls.group_by{|c| c.city}.sort_by{|c| c.last.size}.reverse
  end
  def show
    @grouped = @calls.group_by{|c| c.zip}.sort_by{|c| c.last.size}.reverse
    render :action => 'index' 
  end

  def sales
    
      today       = ProductInvoice.todays_sales_for current_site
      yesterday   = current_site.product_invoices.where("DATE(created_at) = ?", Date.yesterday)
      week        = ProductInvoice.sales_since(current_site, 7)
      thirty      = ProductInvoice.sales_since(current_site, 30)   
      year        = ProductInvoice.sales_since(current_site, 365)

      @recents = [today, yesterday, week, thirty, year]

  end

  
private
  def set_calls
    @calls = current_site.incoming_calls.where("created_at > ?", 1.month.ago)
  end
end