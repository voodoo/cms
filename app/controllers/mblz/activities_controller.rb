class Mblz::ActivitiesController < MblzController
  def index
    @activities = current_site.activities.page(params[:page])
 	  if params[:t] && params[:t] != 'All'
 	    @activities = @activities.where(trackable_type: params[:t])
 	  end
 	  if params[:user_id].present?
 	  	@user = current_site.users.find(params[:user_id])
 	    @activities = @activities.where(user_id: @user.id)
 	  end

  end

end
