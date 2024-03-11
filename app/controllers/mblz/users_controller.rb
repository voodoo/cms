class Mblz::UsersController < MblzController
  
  def index
    @user = current_user
  end
  
  def update
    @user = current_user
    if current_user.update_attributes(user_params)
      redirect_to mblz_user_path(current_user)
      flash[:notice] = 'Settings updated'
    else
      render action: 'index'
    end
  end

  def show
    @user = current_site.users.find(params[:id])    
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :pin, :password, :password_confirmation)
  end
end