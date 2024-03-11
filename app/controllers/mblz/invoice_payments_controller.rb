class Mblz::InvoicePaymentsController < MblzController
  before_filter :set_invoice
  def new
    @invoice_payment = @invoice.invoice_payments.new
  end

  def create
    @invoice.invoice_payments.create(params[:invoice_payment].merge(:user_id => current_user.id))
    flash[:notice] = "Payment created"
    redirect_to mblz_invoice_path(@invoice)
  end

  private
  def set_invoice
    @invoice = current_site.invoices.find(params[:invoice_id])
  end
end