class Admin::DomainsController < MblzController
  before_filter :set_site

  def index
    #@domains = Site.find(params[:site_id]).domains
  end

  def show
    @domain = @site.domains.find(params[:id])
  end

  def new
    @domain = Domain.new(:site_id => @site.id)
  end

  def edit
    @domain = @site.domains.find(params[:id])
  end

  def create
    @domain = @site.domains.create!(domain_params)
    redirect_to(admin_site_path(@domain.site))
  end

  def update
    @domain = @site.domains.update(params[:id], domain_params)
    redirect_to(admin_sites_path)
  end

  def destroy
    @site.domains.find(params[:id]).destroy
    redirect_to(admin_sites_path)  
  end
  
  protected
  def set_site
    if params[:site_id]
      @site = Site.find(params[:site_id]) 
      @domains = @site.domains
    else
      @domains = Domain.order('updated_at desc')
    end
  end

  def domain_params
    params.require(:domain).permit!
  end

end
