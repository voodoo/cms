module Mblz::ContactsHelper
  def link_to_call(contact)
    vars = {
              "From" => current_site.twilio_config.incoming_phone,
              "To" => params[:phone],
              site_id: current_site.id,
              contact_id: contact.id
            }.to_json
    link_to "javascript:twilio_call(#{vars})", :id => 'aCall'  do
      yield
    end
  end
  # def get_emails
  #   [current_site.email,current_site.sms].map{|e| e.blank? ? nil : e}.compact.join(', ')
  # end
  # def get_comment
    
  # end
end