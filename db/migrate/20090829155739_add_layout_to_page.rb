class AddLayoutToPage < ActiveRecord::Migration
  def self.up
    add_column :boots, :layout_id, :integer
    for page in Page.all
      page.update_attributes(:layout_id => page.site.layouts.first.id)
    end
    
  end

  def self.down
    remove_column :boots, :layout_id
  end
end
