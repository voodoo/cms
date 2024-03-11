module Cms::PagesHelper
  def pages_select page
    @current_site.pages.all.map{|p| [p.title, p.id] if p != page}.compact
  end
end
