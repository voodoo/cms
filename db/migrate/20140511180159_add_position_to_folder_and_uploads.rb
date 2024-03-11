class AddPositionToFolderAndUploads < ActiveRecord::Migration
  def up
  	add_column :uploads, :position, :integer#, default: nil
    Site.all.each do |site|
      site.folders.each_with_index do |folder,idxf|
        folder.update_attribute(:position, idxf+1)
        folder.uploads.each_with_index do |upload, idx|
          upload.update_attribute(:position, idx+1)
        end
      end       
    end
 
  end

  def down
 	  remove_column :uploads, :position
  end
end
