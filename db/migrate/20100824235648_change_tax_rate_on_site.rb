class ChangeTaxRateOnSite < ActiveRecord::Migration
  def self.up
    change_column :sites, :tax_rate, :decimal, :precision => 6, :scale => 6, :default => 0.08125
  end

  def self.down
    change_column :sites, :tax_rate, :decimal, :precision => 4, :scale => 4, :default => 0.0825
  end
end
