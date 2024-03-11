class Mblz::CommentsController < MblzController
  before_filter :set_contact, :except => [:index, :new, :create]
  
  def index
    @comments = current_site.comments.order('created_at desc').page(params[:page])
  end

  def show
    @title = "Comment" 
    if !@comment.commentable 
      emergency_contacts =current_site.contacts.with_priority
      @contacts = (emergency_contacts + current_site.contacts.limit(15).order('updated_at desc').uniq) 
      @invoices = current_site.invoices.limit(15).order('updated_at desc').uniq
    end 
  end

  def new
    
    contact, invoice = params[:contact_id], params[:invoice_id]
    if contact
      @title = "New Contact Comment"
      @contact = current_site.contacts.find(contact)
      @comment = @contact.comments.new
    else
      @title = "New Invoice Comment"
      @invoice = current_site.invoices.find(invoice)
      @comment = @invoice.comments.new      
    end
  end

  def set_link
    commentable_id, commentable_type = params[:contact_id] ? [params[:contact_id], 'Contact'] : [params[:invoice_id], 'Invoice']
    @comment.update_attributes(user_id: current_user.id, commentable_id: commentable_id, commentable_type: commentable_type)  
    flash[:notice] = "Comment linked"
    redirect_to mblz_contact_comment_path(commentable_id,@comment)
  end

  def create
    @comment = current_site.comments.create(comment_params)
    track_activity @comment

    redirect_to polymorphic_path([:mblz,@comment.commentable, @comment])
  end
  
  def destroy
    @comment.destroy
    track_activity @comment
    redirect_to mblz_comments_path, :notice => "Comment destroyed"
  end

  private

  def set_contact
    @comment = current_site.comments.find(params[:id])
    if commentable = @comment.commentable
      if commentable.respond_to?(:contact)
        @contact = commentable.contact
        @invoice = commentable
      else
        @contact = commentable
      end
    end
  end

  def comment_params
    params.require(:comment).permit!.merge(user_id: current_user.id)
  end
 
end
