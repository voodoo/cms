xml.instruct!
xml.Response do  
	xml.Gather(numDigits: 1, action: twilios_console_boards_path, method: "POST") do
  	xml.Say "Main menu"

		if @messages.count.zero?
			xml.Say "You don't have any messages"
		else
		  xml.Say "Press 1 to listen to #{pluralize(@messages.size, 'message')}"
		end
	  
	  unless @contacts.count.zero?
	    xml.Say "Press 2 to listen to #{pluralize(@contacts.size, 'contact')}"
	  end


	  xml.Say "Press 3 to change your pin"

	  if current_user.admin? or current_user.owner? or current_user.manager?

	  	xml.Say "Press 4 to change your greeting "
	  
	  end

	

  end

  xml.Redirect(twilios_console_root_path, method: :get)

end
