class Twilios::Console::PinsController < Twilios::BaseController
  before_filter :require_console_user

	def index
	end

	def create
		@digits = params[:Digits]
		@current_user.update_attribute(:pin, @digits)
	end

end
