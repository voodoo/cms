class Faq < ActiveRecord::Base
  #versioned
  belongs_to :site
  validates_presence_of :question, :answer
end
