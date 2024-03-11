xml.instruct!

xml.Response do  
  
  if @messages.size.zero?
    xml.Say 'Nothing to report'
    xml.Redirect(twilios_console_root_path, method: :get)
  end

  xml.Say(" You have #{pluralize(@messages.count, 'messages')}. Press 1 to release or 2 to skip message")
  
  @messages.each do |message|
    xml.Gather(numDigits: 1, action: twilios_console_messages_path(id: message.id), method: :post) do
      xml.Play message.recorded_message_url
      xml.Say "Press 1 to release message."
    end

  end

  xml.Redirect(twilios_console_root_path, method: :get)

end
