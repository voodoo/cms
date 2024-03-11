class Mailer < ActionMailer::Base
  default :from     => APP_CONFIG[:from_email],
      :bcc          => 'paul.vudmaska@gmail.com',
      :content_type => "text/html",
      :to           => APP_CONFIG[:email]["admin"]

  def ping title, message, request
    @message = message
    @request = request
    mail(subject: "Notice from CMS - #{title}")
  end

  def form name, message, request
    @message  = message
    @name     = name
    @request  = request
    mail(to: $ITE.email, subject: "form Received")
  end

  def xhr_form request, params
    @params   = params
    @request  = request
    mail(subject: "iPhone Form Received")
  end

  def paypal parms, cancel = nil
    @parms  = parms
    @cancel = cancel
    mail(subject: "Paypal Generated")
  end

  def phone_message thecall, request
    @thecall = thecall
    @request = request
    mail(to: thecall.site.twilio_config.email, subject: "Twilio - #{thecall.calling.to_phone}")
  end

  def admin_phone_message params
    @params = params
    mail(subject: "Twilio phone message")
  end

  def export_contact owner_email, contact
    att = {mime_type: 'text/x-vcard', content: contact.vcard }
    attachments[contact.last_name] = att
    #attachment :content_type => "text/x-vcard",  :body => contact.vcard, :filename => contact.last_name
    mail(to: owner_email, subject: "Contact Export- #{contact.full_name}")
  end

  def daily_activity
    @activities = Activity.where("created_at > ?", 1.days.ago).order('created_at desc')
    mail(subject: "Daily MBLZ activity")    
  end

  # def send_to_owner user, contact, params
  #   recipients   params[:email]
  #   from         APP_CONFIG[:from_email]
  #   bcc          APP_CONFIG[:blind_email]
  #   subject      "Contact - #{contact.full_name}"
  #   sent_on      Time.now
  #   body[:params] = params
  #   body[:contact] = contact
  #   part "text/plain" do |p|
  #     p.body "https://#{contact.site.domains.first.host}/cms/contacts/#{contact.id}" + "\n\n" + params[:comment]
  #   end
  #   #attachment :content_type => "text/x-vcard",  :body => contact.vcard, :filename => contact.last_name

  # end

end
