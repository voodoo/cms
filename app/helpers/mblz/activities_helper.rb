module Mblz::ActivitiesHelper
  def trackable_icon trackable_type
    icons = {
    	    user:          'user',
          incoming_call: 'phone', 
          outgoing_call: 'phone', 
          contact:       'user', 
          invoice:       'file-text', 
          product_invoice: 'file-text-o',
          comment:       'comment'
    }

    "fa-#{icons[trackable_type.underscore.to_sym]}"

  end

end