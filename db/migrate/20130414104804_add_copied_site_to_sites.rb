class AddCopiedSiteToSites < ActiveRecord::Migration
  def change
    add_column :sites, :copied_site_id, :integer
  end
end
