class Admin::TagsController < MblzController
  before_filter :set_site_tag, only: [:edit, :update, :destroy]
  before_filter :set_if_new_category, only: [:update, :create]
  def index
    if params[:site_id]
      @site = Site.find(params[:site_id])
      @tags = @site.tags
    else
      @sites = Tag.group(:site_id).map{|t| t.site}
    end
  end

  def site
    @site = Site.find(params[:site_id])
    @tags = @site.tags
  end

  def edit
    @catagories = @site.tag_categories
    @title  = @site
    @label  = 'Edit Tag'
  end

  def update
    @tag.update_attributes(strong_params)
    flash[:notice] = "Tag updated"
    redirect_to admin_site_tags_path(@site)
  end

  def new
    @site   = Site.find(params[:site_id])
    @tag    = @site.tags.new
    @title  = @site
    @label  = 'New Tag'
  end  

  def create
    @site = Site.find(params[:site_id])
    @tag  = @site.tags.create(strong_params)
    flash[:notice] = "Tag created"
    redirect_to admin_site_tags_path(@site)    
  end 

  def destroy
    @tag.contacts.delete_all
    @tag.destroy
    flash[:notice] = "Tags destroyed"
    redirect_to admin_site_tags_path(@site)      
  end   

private

  def set_if_new_category
    new_category = params[:new][:category]
    if !new_category.blank?
      params[:tag][:category] =  new_category
    end    
  end

  def set_site_tag
    @site = Site.find(params[:site_id])
    @tag  = @site.tags.find(params[:id])
  end

  def strong_params
    params.require(:tag).permit(:name, :category)
  end
end
