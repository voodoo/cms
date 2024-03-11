# * Polymorphic phone class
class Phone < ActiveRecord::Base
  belongs_to :phoneable, :polymorphic => true
  validates_presence_of :number
  scope :active, -> {where(active: true)}
  scope :during_this_time,  -> { Time.now.utc.getlocal('-05:00').hour >= 17 ? where(after_five: true) : where(before_five: true)   }
  # take out chars from mask
  before_save do |model|
    model.number = model.number.to_s.gsub(/\D/,'')
  end  
end
