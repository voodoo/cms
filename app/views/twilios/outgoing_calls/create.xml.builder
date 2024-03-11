xml.instruct!
xml.Response do  
 xml.Say @call.contact.full_name
 xml.Dial(callerId: @twilio.incoming_phone, record: true, action: '/twilios/outgoing_calls/complete') do
 		xml.Number @phone
 end
end

# xml.instruct!
# xml.Response do  
#  xml.Dial(:callerId => @outgoing.from , :record => true, :action => "/twilios/outgoing_calls/#{@outgoing.sid}/update_call") do 
#     xml.Number(@outgoing.to)
#  end
# end