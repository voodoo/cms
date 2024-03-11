class Product < ActiveRecord::Base
  Paperclip.options[:command_path] = "/usr/local/bin/identify"
  has_attached_file :image,
     :styles => {
       :thumb=> "100x100#",
       :small  => "300x300>" }
  validates_attachment :image, :content_type => { :content_type => /image/ }     
  #validates :image, :attachment_presence => false
  validates_attachment_size :image, 
                              :less_than    => 1.megabytes, 
                              :unless       => Proc.new {|m| m[:image].nil?}   
  validates_presence_of :name, :location
  belongs_to :site
  has_many :product_invoice_items
  belongs_to :product_inventories
  belongs_to :product_category 
  belongs_to :product_section

  scope :active, lambda {where(inactive: false)}

  def suggested_price
    cost * markup
  end

  def category_location
    self.product_category.name.first + self.location.to_s
  end

  def update_inventory
    details = ProductInventory.details_for(self.site,self)
    update_attribute(:inventory, details[:projected_count])
  end

  SUN   = {Shaded: 0, PartiallyShaded: 1, FullSun: 3}
  WATER = {Light: 0, Weekly: 1, Heavy: 3}

  def sun_name
    SUN.key(self.sun)
  end

  def water_name
    WATER.key(self.water)
  end
  
  def self.options_for_category_select
    ProductCategory.all.map{|k| [k.name, k.id]}
  end

  def self.options_for_section_select
    ProductSection.all.map{|k| [k.name, k.id]}
  end

  def self.options_for_sun_select
    SUN.map{|k,v| [k, v]}
  end

  def self.options_for_water_select
  	 WATER.map{|k,v| [k, v]}
  end

before_save :extract_dimensions
serialize :dimensions

# Helper method to determine whether or not an attachment is an image.
# @note Use only if you have a generic asset-type model that can handle different file types.
def image?
  image_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
end

private

# Retrieves dimensions for image assets
# @note Do this after resize operations to account for auto-orientation.
def extract_dimensions
  return unless image?
  tempfile = image.queued_for_write[:original]
  unless tempfile.nil?
    geometry = Paperclip::Geometry.from_file(tempfile)
    self.dimensions = [geometry.width.to_i, geometry.height.to_i]
  end
end  
end
