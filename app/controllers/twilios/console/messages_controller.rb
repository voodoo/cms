class Twilios::Console::MessagesController < Twilios::BaseController

	def index
		@messages = current_site.incoming_calls.console_messages
	end

	def create
		@digit = params[:Digits]
		session[:skipped_messages] ||= []

		if @digit == '1'
			current_site.incoming_calls.console_messages.find(params[:id]).release_from_console!
		elsif @digit == '2'
			session[:skipped_messages] << params[:id].to_i
		end

		@messages = current_site.incoming_calls.console_messages.reject{|cm| session[:skipped_messages].include? cm.id}

	end

end

