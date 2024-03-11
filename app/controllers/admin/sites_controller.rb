class Admin::SitesController < MblzController
  def index
    @sites = Site.where("id <> ? ", current_site.id).order('updated_at desc')
    @sites  =  [current_site] + @sites
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new()
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to admin_site_path(@site), :notice => "Site created"
    else
      render :action => 'new'
    end
  end

  def update
    @site = Site.find(params[:id])
    @site.update_attributes(site_params)
    flash[:notice] = "Update Complete"
    redirect_to admin_site_path(@site)
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    flash[:notice] = "Site was deleted"
    redirect_to(admin_sites_path)
  end

 def search
   @sites = Site.search(params[:search][:q]).paginate(:per_page => 10, :page => params[:page])
   render :action => :index
 end

def fake_data
  site = Site.find(params[:id])
  if params[:clr] == '1'
    site.clear_fake_data!
  else
    site.fake_data!
  end
  redirect_to admin_site_path(site)
end

 def update_namespace
  Site.find(params[:id]).update_namespace(params[:p].gsub('namespace',''))
  render :nothing => true
 end

 def utility
   @cost      = {calls: 0.5, contacts: 1, estimates: 2, invoices: 4, paid_invoices: 0.03}
   @site      = Site.find(params[:id])
   @calls     = @site.incoming_calls.recent
   @contacts  = @site.contacts.recent
   @estimates = @site.invoices.recent
   @invoices  = @site.invoices.where("updated_at > ? and status > 3", 30.days.ago)
   @paid_invoices  = @site.invoices.where("updated_at > ? and status = ?", 30.days.ago, 5)
 end

  private

  def site_params
    params[:site][:tax_rate] = params[:site][:tax_rate].to_f

    params.require(:site).permit!
  end

end
