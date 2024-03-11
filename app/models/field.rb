class Field < ActiveRecord::Base
  belongs_to :form
  acts_as_list scope: :form
  validates_presence_of :title
  before_validation :create_name_from_title
 
  def create_name_from_title
    self.name = self.title.to_slug
  end    
end
