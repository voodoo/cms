class Activity < ActiveRecord::Base
	scope :recent, lambda {where("created_at > ?", 30.days.ago)}
  belongs_to :user
  belongs_to :site
  belongs_to :contact
  belongs_to :trackable, polymorphic: true
  #attr_accessible :action, :trackable, :site_id, :contact_id, :user_id, :note
end
