class AddWrapperToForms < ActiveRecord::Migration
  def change

    add_column :submissions, :suspicious_att, :string
    add_column :forms, :wrapper, :text
    add_column :sites, :invoice_wrapper, :text
  end
end
