class AddWrapperToFolderForGallery < ActiveRecord::Migration
  def change
    add_column :folders, :gallery_wrapper, :text 	
  end
end
