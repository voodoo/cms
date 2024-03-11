module Mblz::IncomingCallsHelper
	def icon_theme_for call
		icon_theme = [nil,nil]
    if call.recorded_message_url.present? 
    	icon_theme = ['star','g']
    elsif call.recording_url.present?
    	icon_theme = ['info','b']
    end
    icon_theme
	end
end

