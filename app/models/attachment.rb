class Attachment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :invoice_item
  acts_as_list scope: [:invoice_id, :before_or_after]
  Paperclip.options[:command_path] = "/usr/local/bin/identify"
  has_attached_file :image,
     # :path => ":rails_root/public/system/attachments/:invoice_id/:style/:basename.:extension",
     # :url  => "/system/attachments/:invoice_id/:style/:basename.:extension",
     :styles => {
       :thumb=> "100x100#",
       :small  => "300x300>" }
  validates_attachment :image, :content_type => { :content_type => /image/ }     
  validates :image, :attachment_presence => true
  validates_attachment_size :image, 
                              :less_than    => 1.megabytes, 
                              :unless       => Proc.new {|m| m[:image].nil?}       

  def title_plus
    title
    if invoice_item
      title + ' - ' + self.invoice_item.name_plus_note
    else
      title
    end
  end
end
