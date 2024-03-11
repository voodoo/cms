class Twilios::Console::AuthsController < Twilios::BaseController

	def index
		
	end
	
	def create
		@authed = @call.user_with_matching_pin(params[:Digits])
		if @authed
			session[:current_user_id] = @authed.id
		end
	end

end

