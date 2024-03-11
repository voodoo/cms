xml.instruct!
xml.Response do  
  xml.Say "Thank you, your pin has been updated"
  xml.Redirect(twilios_console_root_path, method: :get)
end
