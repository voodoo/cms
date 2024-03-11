xml.instruct!
xml.Response do  
  xml.Gather(numDigits: 4, action: twilios_console_pins_path, method: :post) do
     xml.Say "What would you like your new pin to be?"
  end
end