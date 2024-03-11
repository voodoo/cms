class HereIAmMailer < ActionMailer::Base

  def where_are_you(email, counter)
  	@body = counter
  	mail(to: email, subject: "where are you" , from: 'here_i_am@mblz.com')
  end

end
