xml.instruct!
xml.Response do  
	case @digit
	when '1'
		xml.Say 'Message released'
	end

	if @messages.count.zero?
		xml.Redirect twilios_console_root_path, method: :get
	else
		xml.Redirect twilios_console_messages_path, method: :get
	end
end
