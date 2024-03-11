class Admin::ActivitiesController < MblzController

 def index
 	 @in_admin = true
 	 @activities = Activity.order('created_at desc').page(params[:page]) 
 	 if params[:t] && params[:t] != 'All'
 	    @activities = @activities.where(trackable_type: params[:t])
 	 end
   
 end  


end
