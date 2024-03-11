class Twilios::Console::GreetingsController < Twilios::BaseController
	def index
	end

	def create
		@digit = params[:Digits]
		if @digit == '1'
			@greeting = current_site.twilio_config.leave_message
		end
	end

	def recorded
		current_site.twilio_config.update_attribute(:leave_message, params[:RecordingUrl])
		redirect_to twilios_console_greetings_path
	end


end

