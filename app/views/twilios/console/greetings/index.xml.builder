xml.instruct!
xml.Response do  
  xml.Gather(numDigits: 1, action: twilios_console_greetings_path, method: :post) do
    xml.Say "Press 1 to listen to your greeting prompt"
    xml.Say "Press 2 to record your greeting prompt"
  end
end