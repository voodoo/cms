class Mblz::InvoicesController < MblzController
  before_filter :set_invoice, :except => [:index, :item, :client, :paid]
  helper_method :report_year_for
  
  skip_before_filter :has_permission?, :only => [:client]
  skip_before_filter :require_user, :only => [:client]


  def show
    if @invoice.received_by.blank?
      if current_user.owner?
        track_activity @invoice, "Received by owner"
        @invoice.update_attribute(:received_by, current_user)
      end
    end  
  end

  def dupe
    duped          = current_site.invoices.find(params[:id]).dupe(current_user)
    track_activity @invoice
    flash[:notice] = "Invoice was duplicated"
    redirect_to mblz_invoice_path(duped)
  end

  def index
    conditions = params[:s] ? ["invoices.status = ?", params[:s].to_i] : []
    @invoices = current_site.invoices.where(conditions).includes([:contact, :invoice_items]).order('invoices.updated_at desc').page(params[:page]).per(50)     
  end

  def map
    conditions = params[:s] ? ["invoices.status = ?", params[:s].to_i] : []
    invoices   = current_site.invoices.where(conditions).includes([:contact, :invoice_items]).order('invoices.updated_at desc').page(params[:page]).per(50)     
    @contacts  = Contact.geocode_all!(invoices.map{|i| i.contact})    
    render layout: 'invoice_map'
  end

  def client
    @invoice = current_site.invoices.find_by_token(params[:id])
    unless @invoice
      client_invoice_not_found
      return
    end
    @invoice.increase_view_count if params[:nc].blank?
    @contact = @invoice.contact

    render :layout => 'invoice'

  end

  def client_invoice_not_found
    render text: "Not found", status: 404
  end

  def paid
    @invoice = current_site.invoices.find_by_token(params[:id])
    note = 'Public invoice'


    unless request.referrer.to_s.include?("paypal")
      err = " : Paypal error / referer = '#{request.referrer.to_s}' which should include 'Paypal'"
      logger.warn err
      #note += err
    end    
    
    # Don't pay again from paypal
    unless @invoice.paid_with_paypal?
      @invoice.invoice_payments.create(:payment_type => 'Paypal', :note => note)
    end

    @contact = @invoice.contact
    
    flash[:notice] = "Thank you for paying with Paypal"

    redirect_to client_invoice_path(@invoice.token)
  end  


  def new
    @invoice = current_site.invoices.new(:contact_id => params[:contact], footer: current_site.invoice_footer)
  end
  
  
  def create
    @invoice = current_site.invoices.create(invoice_params.merge(:user_id => current_user.id))
    @invoice.create_items invoice_item_params
    track_activity @invoice
    redirect_to mblz_invoice_path(@invoice), :notice => "Invoice Created"
  end

  def update
    @invoice.update_attributes(invoice_params)
    @invoice.invoice_items.destroy_all
    @invoice.create_items invoice_item_params
    @invoice.reload
    track_activity @invoice
    flash.now[:notice] = "Invoice Updated"   
    render :action => 'show' 
  end  
  
  def edit
    if @invoice.needs_work_date?      
      flash[:notice] = "Please input a Work Date and Note"
    end
  end
  
  def item
    render :partial => 'item', :layout => false, :locals => {:item => InvoiceItem.new}
  end
  
  def update_status
    status = params[:status]
    old_status = @invoice.status_name
    @invoice.update_attributes(status: status)
    new_status = @invoice.status_name
    @invoice.invoice_statuses.create!(:user_id => current_user.id, :status => status)
    track_activity @invoice, "Status was updated from '#{old_status}' to '#{new_status}'"
    render :text => "Invoice updated to status of '#{@invoice.status_name}'"
  end

  def update_item_publishable
    item = @invoice.invoice_items.find(params[:invoice_item_id])
    item.change_publishable!
    render :text => item.publishable?
  end


  def destroy
    @invoice.destroy
    redirect_to mblz_invoices_path, notice: "Invoice Destroyed"
  end
  def send_to_contact
    @invoice.update_attribute(:sent_to_contact, Time.now)
    InvoiceMailer.sent_to_contact(@invoice).deliver
    @invoice.invoice_statuses.create!(user_id: current_user.id)
    track_activity @invoice
    redirect_to mblz_invoice_path(@invoice), notice: "Invoice sent to client"  
  end

  def reports
    month = params[:m]
    unless month.nil?
      status = InvoiceStatus.status_id('Paid')
      year = report_year_for(month)
      @invoices = Invoice.by_year_month_and_status(current_site, year, month, status)
    end
  end
  
  def export
    month  = params[:m]
    year   = report_year_for(month)
    status = InvoiceStatus.status_id('Invoice')
    csv = Invoice.to_csv year, month, status
    send_data csv, 
            :type => 'text/csv; charset=iso-8859-1; header=present', 
            :disposition => "attachment; filename=invoices_#{Date.today}_#{year}_#{month}.csv"     
  end

  def export_all
    if current_user.owner_or_above?
      export = Invoice.export_all(current_site)
      send_data export, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=export_invoices_#{current_site.subdomain}.csv"     
    else
      raise "Tried to access contacts"
    end   
  end

  private

  def invoice_params
     params.require(:invoice).permit!
  end

  def invoice_item_params
    params.require(:invoice_item).map do |ii|
      ActionController::Parameters.new(ii.to_hash).permit!
    end
  end

  def report_year_for(month)
    today = Date.today
    m     = today.month
    year  = today.year
    if month.to_i > m
      year - 1
    else
      year
    end
   
  end

  def set_invoice
    @invoice = current_site.invoices.find(params[:id]) if params[:id]
  end

end