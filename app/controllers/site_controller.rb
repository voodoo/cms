# The public site of sites
class SiteController < ApplicationController
  
  skip_before_filter :verify_authenticity_token#, :only => [:paypal]
  
  before_filter :set_page, only: :show_page #except: [:sitemap, :robots, :contact, :css]

  def show_page    
  
    if @page 
      @page_params = {
        'page'        => @page,
        'page_name'   => @page.name,
        'params'      => request.params,
        'meta_description' => @page.meta_description.blank? ? current_site.biz_description : @page.meta_description ,
        'meta_keywords' => @page.meta_keywords.blank? ? current_site.biz_keywords :  @page.meta_keywords,
        'page_title'  => @title || @page.title,
        'controller'  => controller_name,
        'host'        => request.host,
        'action'      => action_name,
        'user'        => current_user,
        'used_google_adwords' => session[:used_google_adwords]
      }
      render :layout => 'site', :content_type => 'text/html'
    else
      not_found
    end
  end

  def robots
    render layout: false, content_type: 'text/plain'  
  end

  def sitemap
    if request.subdomains.first != 'www'
      render nothing: true
    else
     @pages = current_site.pages.non_partial
    render layout: false
    end
  end

  def contact
    @site   = current_site
    @layout = @site.layouts.first.text
    @page_params = {
      'page_title'  => "Contact us"
    }
    render layout: 'cms_site'
  end

  def css
    styles = @current_site.styles
    css = styles.map{|s| s.text}.join("\n") unless styles.empty?
    if css
      render :text => css, :content_type => 'text/css', :layout => false
    else
      render :nothing => true
    end
  end

  private

  def set_page
    page_name = params[:url]
    if page_name.blank?
      @page = current_site.root_page
    else
      @page = current_site.pages.find_by_path(page_name)
    end     
  end
  

end