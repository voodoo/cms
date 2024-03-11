class UpdateTaxes < ActiveRecord::Migration

  def up
    add_column :invoices, :tax_rate, 
               :decimal, :precision => 10, :scale => 5, :default => 0.0825
    change_column :sites, :tax_rate, :decimal,
                  :precision => 10, :scale => 5, :default => 0.0825

    Invoice.where("created_at < ?", Date.new(2013, 4, 1)).each do |invoice|
      invoice.update_attribute(:tax_rate, 0.08125)
    end
    Site.all.each do |site|
      site.update_attribute(:tax_rate, 0.08250)
    end    
  end

  def down
    remove_column :invoices, :tax_rate    
    
  end

end
