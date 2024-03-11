class AddPhonesToContact < ActiveRecord::Migration
  def self.up
    rename_column :contacts, :mobile, :cell_phone
    rename_column :contacts, :fax,    :other_phone
  end

  def self.down
  end
end
