class Folder < ActiveRecord::Base
  belongs_to :site
  acts_as_list scope: :site
  has_many :uploads, -> { order("position ASC") }, dependent: :destroy
  validates_uniqueness_of :name, scope: :site_id

  def move! direction
    if direction == 'up'
      self.move_higher
    else
      self.move_lower
    end
  end     
end
