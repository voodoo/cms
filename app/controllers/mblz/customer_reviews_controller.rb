class Mblz::CustomerReviewsController < MblzController
  before_filter :hide_in_public, only: :index
  skip_before_filter :has_permission?
  skip_before_filter :require_user
  skip_before_filter :verify_authenticity_token
  layout false

  
  
  def index
    
    reviews = Review.publishable(current_site)

    reviews = reviews.map do |review| 
      invoice = review.invoice
      contact = invoice.contact
      items   = invoice.invoice_items.reject{|ii| !ii.publishable?}.map do |ii|
        {name: ii.name, note: ii.note}
      end

      before_images = invoice.attachments.select{|a| !a.before_or_after}.sort_by{|a| a.position}.map do |att|
          {title: att.title, url: att.image.url}
      end
      after_images  = invoice.attachments.select{|a| a.before_or_after}.sort_by{|a| a.position}.map do |att|
        {title: att.title, url: att.image.url}
      end

      # images   = invoice.attachments.map do |att|
      #   {title: att.title, url: att.image.url}
      # end

      {

        initials: contact.initials,
        comment: review.comment,
        items: items,
        images: {before: before_images, after: after_images},
        title: review.title,
        icon: review.icon,
        created_at: invoice.created_at.to_date
      }
    end
    render json: reviews
  end

  def create
    invoice = current_site.invoices.find_by_token(params[:invoice_id])
    @review = invoice.review = Review.create(review_params)
  end


  private
  # Good enough for spiders at least
  def hide_in_public
    if not params.has_key?(:mblz)
      not_found
    end
  end
  def review_params
  	params.require(:review).permit!
  end
end