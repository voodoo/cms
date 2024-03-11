class Admin::IncomingCallsController < MblzController

 def index
 	 @calls = IncomingCall.order('created_at desc')
 	 q = params[:q].to_s.strip
 	 if q.present?	 
 	   @calls = @calls.where("calling like ?", "%#{q}%")
 	 end
 	 @calls = @calls.page(params[:page]) 
 end  

end
