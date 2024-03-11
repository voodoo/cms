class UserSession < Authlogic::Session::Base

  remember_me true
  find_by_login_method :find_by_login_or_email

  extend ActiveModel::Naming
  

end