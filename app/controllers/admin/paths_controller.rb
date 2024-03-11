class Admin::PathsController < MblzController

  def index
    @paths = Path.where nil
    if params[:q]
      @paths = Path.search_for(params[:q])
    end
    @paths = @paths.order('created_at desc').group('session_id').page(params[:page])
  end

  def site
    @site  = @site = Site.find(params[:id])
    @paths = @site.paths.order('created_at desc').group('session_id').page(params[:page])
    if params[:q]
      @paths = @paths.search_for(params[:q])
    end
    render :index
  end

  def show
    @path = Path.find(params[:id])  
  end



  def by_session
    @paths = Path.order('created_at desc').where("session_id = ?", params[:id])
    @site  = @paths.first.site
  end

  def sites
    @site_paths = Path.order('created_at desc').group('site_id')
                  .map{|p| {site: Site.find(p.site_id), paths: Path.where(site_id: p.site_id)}}
                  .sort_by{|p| p[:paths].size}.reverse
  end
  
  def clear
    paths = Path.where('created_at < ?', 1.day.ago)
    size = paths.size
    paths.delete_all
    flash[:notice] = "#{size} paths deleted"
    redirect_to admin_paths_path
  end

  def destroy
    if params[:id] =~ /^\d+$/
      path = Path.find(params[:id])
      site = path.site
      path.delete
    else
      paths = Path.where("session_id = ?",params[:id])
      site  = paths.first.site
      paths.delete_all
    end
    redirect_to site_admin_path_path site
  end

end
