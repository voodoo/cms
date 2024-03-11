xml.instruct!
xml.Response do
  
  if @twilio.plays_quality_assurance?
    xml.Play "https://api.twilio.com/2008-08-01/Accounts/AC6b0c8045d3f27f8b9e203b6f5a91f6d7/Recordings/RE70cff339caeb59c1e70b998efe910aaf.mp3"
  end

  xml.Dial(:timeout => @twilio.timeout, record: true) do
    for phone in @phones
      xml.Number(phone, url: "/twilios/calls/answered?answered_by=#{phone}")
    end
  end


  if @twilio.leave_message.blank?
    xml.Say "Please leave a message"
  elsif @twilio.leave_message =~ /^https:/
    xml.Play @twilio.leave_message
  else
    xml.Say @twilio.leave_message
  end   

   xml.Record(:action             => "/twilios/calls/recording_complete",
              :transcribe         => true,
              :transcribeCallback => '/twilios/calls/transcription_complete')

end