class Cms::RssController < MblzController
  def index
    @pages = current_site.pages.find(:all, :order => "id DESC", :limit => 10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"    
  end
end
