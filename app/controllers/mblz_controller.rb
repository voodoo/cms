class MblzController < ApplicationController
  layout :set_layout
  
  before_filter :require_user
  before_filter :require_site_user
  before_filter :has_permission?
  helper_method :admin?


  private


  def require_site_user
    if current_user && ! current_user.sites.include?(current_site)
      flash[:notice] = "You must be logged in to access this site"
      redirect_to login_path
      return false
    end   
  end

  # User can access this module?
  def has_permission?
    return true if current_user and current_user.admin?
    if request.path =~ /^\/admin/    #/^(\/admin|\/cms)/  
      redirect_to mblz_root_path, :alert => "Access Denied"
      return false
    end
  end 

  def set_layout
    #lp "xhr=#{request.xhr? ? 'yes' : 'no'}"
    request.xhr? ? 'page' : 'mblz'
  end
end