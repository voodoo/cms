class InvoiceMailer < ActionMailer::Base
  default :from     => APP_CONFIG[:from_email], 
      :bcc          => ['paul.vudmaska@gmail.com','elva.tristan@gmail.com'], 
      :content_type => "text/html"

  def sent_to_contact invoice
    @invoice = invoice
    subject  = "#{invoice.or_estimate} from #{invoice.site.biz_name}"
    mail(to: invoice.contact.email, subject: subject, reply_to: invoice.site.email, bcc: invoice.site.email)
  end

  def estimate_confirmation site, invoice, confirmation
    owner         = site.email
    @invoice      = invoice
    @site         = site
    @confirmation = confirmation
    mail(to: site.email, subject: "Estimate Confirmation")
  end

  private
  # def site_owner_email invoice
  #  [invoice.site.email, invoice.site.sms].compact.reject{|e| e.blank?}.join(',')     
  # end  
end