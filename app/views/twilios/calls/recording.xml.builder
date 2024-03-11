xml.instruct!
xml.Response do

  if @twilio.leave_message.blank?
    xml.Say "Please leave a message"
  elsif @twilio.leave_message =~ /^https:/
    xml.Play @twilio.leave_message
  else
    xml.Say @twilio.leave_message
  end   

   xml.Record(:action             => "/twilios/calls/recording_complete",
              :transcribe         => @transcribe,
              :transcribeCallback => '/twilios/calls/transcription_complete')
   xml.Say "Sorry, your message did not go thru"
end