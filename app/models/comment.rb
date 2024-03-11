class Comment < ActiveRecord::Base
  
  scope :recent, lambda {where("created_at > ?", 30.days.ago)}
  
  scoped_search :on => [:title, :comment]
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :site
  has_many :medias
  has_and_belongs_to_many :users

  CARRIERS = {
    att: "txt.att.net"
  }

  include ActionDispatch::Routing::PolymorphicRoutes
  include Rails.application.routes.url_helpers

  # take out chars from phone
  before_save do |c|
    unless c.from_phone.blank?
      c.to_phone      = c.to_phone.to_s.gsub(/\D/,'').last(10)
      c.from_phone    = c.from_phone.to_s.gsub(/\D/,'').last(10)
    end
  end

  after_create do |comment|
    if !comment.from_phone.blank? # must be incoming?
      attach_user_from_phone
      attach_to_contact_or_invoice
    else
      send_twilio_messages(comment)
    end

  end

  def attach_medias(params)
    0.upto(params[:NumMedia].to_i - 1) do |i|
      url = "MediaUrl#{i}".to_sym
      ct  = "MediaContentType#{i}".to_sym
      medias.create(url: params[url], content_type: params[ct])
    end
  end

  def attach_to_contact_or_invoice
    if /^\#(\d+)/ =~ comment
      #p Invoice.first
      invoice = self.site.invoices.find($1)
      self.update_attributes(commentable_id: invoice.id, commentable_type: 'Invoice')  
    end

  end
  
  def commentable_contact
    if self.commentable.is_a?(Contact)
      self.commentable
    else
      # Invoice contact
      self.commentable.contact
    end
  end 

  def attach_user_from_phone
    if users = site.users.where(phone: from_phone)
      if user = users.first
        self.update_attributes(user_id: user.id)
      end
    end
  end


  def phone_to_carrier_message phone, carrier=:att
    "#{phone}@#{CARRIERS[carrier]}"
  end
  
  def send_twilio_messages comment
    phone = self.site.twilio_config.incoming_phone
    unless phone.blank?
      url =  polymorphic_url([:mblz,comment.commentable, comment], host: comment.site.host)
      for to in users        
        next if to.phone.blank?
        message = "#{comment.title}\n#{comment.comment}".truncate(156)
        Twilio::SMS.create :from =>  phone, :to => to.phone, :body => "#{url}\n#{message}"
      end
    end  
  end

end
