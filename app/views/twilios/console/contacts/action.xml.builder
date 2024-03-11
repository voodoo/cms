xml.instruct!

xml.Response do  

  case @action
    when :call	
      xml.Say "Calling contact #{@contact.full_name}"
      xml.Dial(@contact.phone, timeout: 10, record: false)
    when :release
      if @received
        xml.Say "Marked as received"
      else
        xml.Say "Released Priority"
      end
      xml.Redirect(twilios_console_contacts_path, method: :get)
    when :comment
      xml.Say "Leave comment. Press any key when done"
      xml.Record(
                  action:                recording_complete_twilios_console_contact_path(@contact),
                  transcribe:             true,
                  transcribeCallback:    transcription_complete_twilios_console_contact_path(@contact)
                )    
  end

end
