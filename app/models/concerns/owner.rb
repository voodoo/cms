class Owner
  # If there is a site user of role 'Owner', use that, otherwise use site phone
  def self.phone site
	  phone = nil
	  # Find user with role owner and has a phone
	  users = site.users.where("role = 1 and phone is not null")
	  if users.present?
	  	# TODO: Enforce only one 'Owner' role
	    phone = users.first.phone 
	  elsif !site.phone.blank?
	    phone = site.phone
	  end
		phone	
  end
end