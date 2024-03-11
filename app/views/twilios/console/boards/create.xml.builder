xml.instruct!
xml.Response do  
	case @digit
		when '1'
			xml.Redirect(twilios_console_messages_path, method: :get)
		when '2'
			xml.Redirect(twilios_console_contacts_path, method: :get)
		when '3'
			xml.Redirect(twilios_console_pins_path, method: :get)
		when '4'
			xml.Redirect(twilios_console_greetings_path, method: :get)	
		else
			xml.Redirect(twilios_console_root_path, method: :get)
	end
end
