class Admin::UsersController < MblzController

  skip_before_filter :has_permission?, :only => [:edit, :update]
  before_filter :set_user,             :only => [:edit, :update]

  def index
    @users = User.order("updated_at desc")
  end

  # def show
  #   edit
  #   render :action => :edit
  # end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      #flash[:notice] = "User Updated"
      if current_user.admin?
        redirect_to admin_users_path, :notice => "Update complete"
      else
        redirect_to mblz_root_path, :notice => "User info updated"
      end
    else
      flash.now[:alert] = "Update failed  #{@user.errors.inspect}"
      render :action => 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if params[:site_id].blank?
        @user.sites << current_site
      else
        @user.sites << Site.find(params[:site_id])
      end
      redirect_to edit_admin_user_path(@user), :notice => 'User was successfully created.'
    else
      flash.now[:notice] = "User creation failed"
      render :action => "new"
    end
  end
  # Ajax
  def update_site_access
    user      = User.find(params[:id])
    site_user = user.site_users.where(:site_id => params[:site]).first
    site      = Site.find params[:site]
    msg       = ''
    # user already has this site
    if site_user
      site_user.destroy
      msg = "Removed"
    else
      # does not have access - create it
      user.site_users.create!(:site_id => params[:site])
       msg = "Added "
    end
    render text: [msg, "'#{site.subdomain}'", "to site access"].join(' ')
  end

  private
  def user_params
    params.require(:user).permit!
  end  
  def set_user
    if current_user.admin?
      @user = User.includes(:sites).find(params[:id])
    else
      @user = current_user
    end
  end
end
