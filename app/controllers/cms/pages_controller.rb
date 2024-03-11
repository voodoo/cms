class Cms::PagesController < MblzController
  
  before_filter :require_user
  before_filter :has_permission?
  before_filter :setup, :only => [:show, :edit, :update, :destroy]

  def index
    @page = current_site.root_page
    if @page.nil?
      @page = current_site.pages.create!(:title => "Root Page")
    end
    render :action => 'show'
  end
  
  def show
  end  
  
  def edit
  end 
  
  def destroy
    parent = @page.parent
    @page.destroy    
    redirect_to cms_page_path(parent), :notice => "Page Deleted"
  end  
  
  def update
    if @page.update_attributes(page_params)
      message    = "Update Complete"
      updated_at = @page.updated_at.to_f
    else
      errors  = @page.errors.full_messages.join('<br/>')
      message = "Update Failed! Refresh page please.#{errors}"
      updated_at = nil
    end
    render :json => {message: message, updated_at: updated_at}
  end      
  
  def new
    @page = current_site.pages.find(params[:parent_id]).children.new
  end
  
  def create
    page = current_site.pages.create(page_params)
    redirect_to cms_page_path(page.parent), :notice => "Page was created"
  end
  private
  
  def setup
    @page = current_site.pages.find(params[:id])
  end

  def page_params
    params.require(:page).permit!
  end
end