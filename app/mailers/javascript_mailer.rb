class JavascriptMailer < ActionMailer::Base
  default :from       => APP_CONFIG[:from_email], 
          :to         => ['paul.vudmaska@gmail.com','elva.tristan@gmail.com'], 
          :content_type => "text/html"

  def client_error params
    @params = params
    mail(subject: "Javascript Error")
  end


  private
  # def site_owner_email invoice
  #  [invoice.site.email, invoice.site.sms].compact.reject{|e| e.blank?}.join(',')     
  # end  
end