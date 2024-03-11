class Mblz::ReviewsController < MblzController
  # skip_before_filter :has_permission?
  # skip_before_filter :require_user
  # skip_before_filter :verify_authenticity_token
  # layout false

  before_action :set_invoice_review, except: :index
  
  def index
    @reviews = Review.publishable(current_site)
  end

  def update
    @invoice.review.update_attributes(review_params)  
    flash[:notice] = "Review Updated"
    redirect_to mblz_invoice_path @invoice

  end

  def create
    @invoice.review = Review.create(review_params) 
    flash[:notice] = "Review Created"
    redirect_to mblz_invoice_path @invoice 
  end

  def edit
    
  end

  def destroy
    @review.destroy
    flash[:notice] = "Review deleted"
    redirect_to mblz_invoice_path @invoice     
  end

  private

  def set_invoice_review
    @invoice = current_site.invoices.find(params[:invoice_id])
    @review  = @invoice.review || Review.new
  end
  def review_params
  	params.require(:review).permit!
  end
end