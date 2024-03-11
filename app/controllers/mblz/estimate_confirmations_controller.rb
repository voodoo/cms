class Mblz::EstimateConfirmationsController < MblzController
  skip_before_filter :has_permission?
  skip_before_filter :require_user
  skip_before_filter :verify_authenticity_token
  layout false
  
  def create
    invoice  = current_site.invoices.find_by_token(params[:invoice_id])
    @ec      = invoice.estimate_confirmations.create(estimate_confirmation_params)
    InvoiceMailer.estimate_confirmation(current_site, invoice, @ec).deliver_now
    #render :layout => false
  end

  private
  def estimate_confirmation_params
    sleep 1
  	params.require(:estimate_confirmation).permit!
  end
end
