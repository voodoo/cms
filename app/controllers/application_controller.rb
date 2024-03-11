class ApplicationController < ActionController::Base
  # include LoadSite
  # include CurrentUser
  # include Browser
  before_filter :load_site
  #before_filter :create_public_path
  helper_method :current_user_session, :current_user, 
                :admin?, :iphone?, :current_site, :current_host, :mblz?
  
  attr_reader :current_site
    
  protect_from_forgery


  def mblz?
    request.path =~ /^(\/admin|\/cms|\/mblz)/ 
  end

  def iphone?
    self.request.user_agent =~ /(Mobile\/.+Safari)/
  end

  def admin?
    return false unless current_user
    current_user.admin?
  end

  def store_location
    session[:return_to] = request.url
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = current_site.user_sessions.find
    # UserSession.with_scope(:id => @current_site.subdomain) do
    #   @current_user_session = UserSession.find
    # end
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
  end

  def load_site
    #p request.host
    #p request.subdomains.first
    if domain = Domain.find_by_host(request.host.sub(/^www\./i,''))
      @current_site = domain.site
    else
      @current_site = Site.find_by_subdomain(request.subdomains.first)
    end

    if @current_site.nil?
      if request.host =~ /localhost/ || request.host =~ /192\.168/ || request.host =~ /ngrok\.io$/ || Rails.env.test? # Used in tests :(>)
        #@current_site = Site.first
        @current_site = Site.find(62) #47 heartwood for localhost / 62 paradise
      else
        logger.warn "Subdomain not found #{request.host}"
        raise ActionController::RoutingError.new('Not Found')
        return false
      end
      #@current_site = Site.first
    end
    #nasty hack to get site in liquid extentions
    $ITE = @current_site
    Site.current_site = @current_site

  end

  def current_host
    request.host
  end

  def not_found
    logger.warn "Page not found in site #{request.host}"
    raise ActionController::RoutingError.new('Not Found')
  end



  private

  def infer_contact trackable
    return unless trackable
    return trackable.id if trackable.is_a?(Contact)
    if trackable.is_a?(Comment)
      commentable = trackable.commentable
      if commentable.is_a?(Contact)
        return commentable.id
      elsif commentable.is_a?(Invoice)
        return commentable.contact.id
      else
        return nil
      end
    end
    # must be an Invoice?
    return trackable.contact.id if trackable.contact
    nil
  end


  def track_activity(trackable, note = nil, action = params[:action], user = nil)
    # There might not be a current user - in twilio
    current_user_id = current_user ? current_user.id : (user ? user.id : nil)
    #lp current_user_id
    Activity.create!(
            user_id: current_user_id,
            action: action, 
            trackable: trackable, 
            site_id: current_site.id, 
            contact_id: infer_contact(trackable), 
            note: note
        )
  end

  def not_loggable?(path)
    # cruft from assets
    dont_log_these = APP_CONFIG[:dont_log_these_paths]
    path.start_with?(*dont_log_these)    
  end

  def create_public_path

    fullpath = request.fullpath
    
    # Don't log mblz namespaces
    return if mblz? || not_loggable?(fullpath)

    # convenience so we dont have to look up from paths every time
    if request.fullpath.include?('gclid=')
      session[:used_google_adwords] = true
    end
    
    # have to lazy load session the first time?
    session_id = request.session_options[:id]
    unless session_id
      #logger.warn "Had to lazy load session_id"
      session[:lazy_load] = true
      session_id = request.session_options[:id]
    end

    # return if current_user # or RAILS_ENV != 'production'
    current_site.paths.create(
                :url        => fullpath, 
                :session_id => session_id,
                :ip         => request.remote_ip, 
                :browser    => request.user_agent,
                :referer    => request.referer,
                :params     => params.delete(:tempfile),
                :status     => 200)
  end  


end
