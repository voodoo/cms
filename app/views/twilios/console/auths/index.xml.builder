xml.instruct!
xml.Response do  
  xml.Gather(numDigits: 4, action: twilios_console_auths_path, method: :post) do
     xml.Say "Please enter your 4 digit pin"
  end
end