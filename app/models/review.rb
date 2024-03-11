class Review < ActiveRecord::Base
  belongs_to :invoice
  def publishable?
  	self.confirmed_by_customer &&  self.confirmed_by_owner && self.satisfied && !self.comment.blank?   
  end

  def self.publishable(site)
  	joins({invoice: :contact})
  	  .where("invoices.site_id=#{site.id} and satisfied=true and confirmed_by_owner=true and confirmed_by_customer=true and comment is not null")
  	  .order("created_at desc")

  end
end
