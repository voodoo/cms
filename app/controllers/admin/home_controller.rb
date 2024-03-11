class Admin::HomeController < MblzController

  def index
    q = params[:q]
    unless q.blank?
      @users    = User.search_for(q)
      @sites    = Site.search_for(q)
      @domains  = Domain.search_for(q)
      render :action => 'search'
    end
  end

end
