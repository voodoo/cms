class Upload < ActiveRecord::Base
  validates_uniqueness_of :upload_file_name, :scope => :folder_id
  belongs_to :folder
  acts_as_list scope: :folder
  Paperclip.options[:command_path] = "/usr/local/bin/identify"
  has_attached_file :upload,
     :path => ":rails_root/public/system/uploads/:folder/:style/:basename.:extension",
     :url  => "/system/uploads/:folder/:style/:basename.:extension",
     :styles => {
       :thumb=> "100x100#",
       :small  => "300x300>" }
  validates_attachment :upload, :content_type => { :content_type => /image/ }     
  validates_attachment_size :upload, 
                              :less_than    => 3.megabytes, 
                              :unless       => Proc.new {|m| m[:upload].nil?}       

  def move! direction
    if direction == 'up'
      self.move_higher
    else
      self.move_lower
    end
  end                              
 # def title
 #  upload_file_name.humanize.gsub(/\..+$/,'')
 # end
end
