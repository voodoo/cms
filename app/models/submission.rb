class Submission < ActiveRecord::Base
  
  scope :recent, lambda {where("created_at > ?", 30.days.ago)}

  scoped_search :on => [:response]
  #acts_as_simply_searchable
  belongs_to :form
  belongs_to :site
  serialize :response, JSON
  serialize :tracked_session, JSON
  
  def tracked_session_id= session_id
    self.tracked_session = {
      session_id: session_id, # serialize path url
      paths: self.site.paths.find_all_by_session_id(session_id, :select => :url).map{|p| p.url}
    }
  end

  def suspicious?
    self.black_listed? || self.suspicious_content? || self.bot?
  end

  def bot?
    !self.suspicious_att.blank?
  end

  def black_listed?
    self.site.has_blip_with_ip?(self.ip)    
  end

  def bot?
    !suspicious_att.blank?
  end
  
  def suspicious_content?
    self.response.to_s.include?("href=") || self.response.to_s.include?("http://") || self.response.to_s.include?("https://")
  end

  def is_from_google?
    self.tracked_session.to_s.include?("gclid=") 
  end

  def prolog
    s = ''
    response.slice(0,3).each do |rsp|
      s += "<span style='font-size:12px;color:#666'>" + rsp.keys.first + " = </span> " + rsp.values.first
      s += '<br/>'
    end
    s
  end
end
