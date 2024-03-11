xml.instruct!
xml.Response do  
	case @digit
		when '1'
			if @greeting =~ /^http/
				xml.Play @greeting
			else
				xml.Say @greeting
			end
		when '2'
			xml.Say "Record your message"
	    xml.Record(action: recorded_twilios_console_greetings_path)
	  when '0'
	  	 xml.Redirect twilios_console_root_path, method: :get
	end

  xml.Redirect twilios_console_greetings_path, method: :get
end
