class UserSessionsController < MblzController
  skip_before_filter :require_user
  skip_before_filter :has_permission?
  skip_before_filter :require_site_user

  def index
    redirect_to :action => 'new'  
  end

  def new
    @title = "Log in"
    @user_session = UserSession.new(:remember_me => true)
  end
  
  def create

    @user_session = current_site.user_sessions.new(params[:user_session])

   
    if @user_session.save
      
        Activity.create!(
            user_id: current_user.id,
            action: "login", 
            trackable_id: current_user.id,
            trackable_type: 'User', 
            site_id: current_site.id, 
            contact_id: nil, 
            note: "#{current_user.login} logged in"
        )

      cookies[:login] = {
        value:   params[:user_session][:login],
        expires: 1.year.from_now }
      flash[:alert] = "Successfully logged in."

      response.headers['X-CSRF-Token'] = form_authenticity_token

      redirect_to mblz_root_path, :notice => "Successfully logged in."        
    else
      @login = params[:user_session][:login]
      Mailer.ping('Login FAILURE', params[:user_session][:login], request).deliver_now
      flash.now[:alert] = "Login Failed"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = current_site.user_sessions.find
    reset_session
    @user_session.destroy if @user_session
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end
end
