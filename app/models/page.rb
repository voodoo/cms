class Page < CmsBoot

  scope :non_partial, -> {where("name not like ?",'\_%')}

  #attr_accessible :original_updated_at, :title, :text, :layout_id #...
  #validate :handle_conflict#, only: :update

  belongs_to :site
  belongs_to :layout#, :class_name => "Layout"
  acts_as_tree :order => :position, :scope => :parent_id
  acts_as_list# :scope => [:site, :parent]
 
  validates_uniqueness_of :name, :scope => [:parent_id, :site_id, :type]
  validates_presence_of :name, :title
  before_validation :create_name_from_title
  def create_name_from_title
    self.name = self.title.to_slug
  end

  def self.copy_pages page, site, parent
    my_parent = site.pages.create!(
        text: page.text, 
        title: page.title, 
        layout_id: site.layouts.first.id,
        parent_id: parent ? parent.id : nil
    )
    for child in page.children
      copy_pages child, site, my_parent
    end
  end


  def original_updated_at
    @original_updated_at || updated_at.to_f
  end
  attr_writer :original_updated_at

  def handle_conflict
    return true if self.new_record?
    if @conflict || updated_at.to_f > original_updated_at.to_f
      @conflict = true
      @original_updated_at = nil
      errors.add :base, "This record changed while you were editing. Take these changes into account and submit it again."
      if changes.empty?
        @conflict = false
      else 
        changes.each do |attribute, values|
          errors.add attribute, "was #{values.first}"
        end
      end
    end
  end
    
  def children?
    children.size > 0 
  end
  # scope_condition for acts_as_list
  def scope_condition
    "parent_id = #{parent_id || 'null'} AND site_id = #{site_id}"
  end

      
  def is_root?
    parent_id.nil?  
  end
  
  liquid_methods :name, :title, :text, :children, :image, :thumb, :price, :note, :path#, :find
  # def to_liquid
  #     {'path' => path}
  # end

  def path     
   s = [self.name]
   path_part = self.parent
   while(!path_part.nil?)   
     s << path_part.name 
     path_part = path_part.parent 
   end   
   s.pop               
   "/#{s.reverse.join('/')}"
  end
  
  def self.find_by_path url
    return unless url
    
    if url == '/' 
      root
    else         
      # In case called from Liquid
      if [ActiveSupport::SafeBuffer, String].include?(url.class)
        url = url.to_s.split('/')
      end          
      node = nil
      #first = true
      url.each do |page|
        unless node.nil?
          node = node.children.find_by_name page
        else       
          #if first   
           node = root.children.find_by_name(page)
          #end
        end
        #first = false
      end   
      node
    end
  end  
end
