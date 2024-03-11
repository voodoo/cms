class AddPinnedToSites < ActiveRecord::Migration
  def change
    add_column :sites, :pinned, :boolean, default: false
    add_column :twilio_configs, :plays_quality_assurance, :boolean, default: true
  end
end
