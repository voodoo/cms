class Form < ActiveRecord::Base
  belongs_to :site
  has_many :fields, -> { order('position')}, dependent: :destroy
  has_many :submissions
  #acts_as_list :scope => :site_id
  before_validation :create_name_from_title

  def create_name_from_title
    self.name = self.title.to_slug
  end



end
