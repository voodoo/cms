class AddImportantToInvoicesAndContacts < ActiveRecord::Migration
  
  def change
    add_column :contacts, :emergency, :boolean, :default => 0
  end


end
