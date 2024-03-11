xml.instruct!

xml.Response do  
	
	if @contacts.size.zero?
		xml.Say 'No priority contacts'
    xml.Redirect(twilios_console_root_path, method: :get)
	end

	xml.Say "#{@contacts.size} priority contacts. "
  
  @contacts.each do |contact|
  	xml.Gather(numDigits: 1, action: action_twilios_console_contact_path(contact)) do
      xml.Say "Contact name #{contact.full_name}"
      xml.Pause
      if contact.priority.zero?
        xml.Say "Invoice not received by owner"
      else
        xml.Say "Priority #{Contact::PRIORITY[contact.priority][:name]}"
      end

      xml.Pause

      if invoice = contact.invoices.last
      	xml.Say "Invoice #{invoice.id} is in status #{invoice.status_name} for the amount of #{twilio_number_to_currency(invoice.total)}"
      end

      
      board_options.each do |key, value|
        if key == "2" && contact.priority.zero?
          xml.Say "Press 2 to mark as received by owner"
        else
          xml.Say "Press #{key} to #{value[:action]}"
        end
      end
    end
  end


  xml.Redirect(twilios_console_root_path, method: :get)

end
