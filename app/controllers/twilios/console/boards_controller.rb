class Twilios::Console::BoardsController < Twilios::BaseController
  before_filter :require_console_user
	def index
		@contacts = current_site.contacts_for_phone_console 
		@messages = current_site.incoming_calls.console_messages
	end

	def create
		@digit = params[:Digits]
	end

end

