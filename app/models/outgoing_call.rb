class OutgoingCall < ActiveRecord::Base
  
  scope :recent, lambda {where("created_at > ?", 30.days.ago)}

  scoped_search :on => [:contact_phone]
  belongs_to :site
  belongs_to :contact
  belongs_to :user
  serialize :paths
  serialize :status
  
  


  def recording
    recordings.first
  end
  def recording?
    !recordings.empty?
  end


end
