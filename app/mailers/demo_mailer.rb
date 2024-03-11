class DemoMailer < ActionMailer::Base
  default :from     => APP_CONFIG[:from_email],
      :bcc          => APP_CONFIG[:bcc_email],
      :content_type => "text/html"



  def send_to_email(demo)
    @demo = demo
    @host = host
    mail(to: demo.email, subject: "MBLZ demo", reply_to: 'demo@mblz.com')

  end

  def welcome demo
    @host = "https://#{demo.subdomain}.#{Rails.env.development? ? 'cms.dev' : 'mblz.com'}"
    mail(to: demo.email, subject: "Your site is ready", reply_to: 'demo@mblz.com')
  end

  private

  def host
    "https://#{Rails.env.development? ? 'cms.dev' : 'mblz.com'}"    
  end
end
