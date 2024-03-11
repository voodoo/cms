class AddSeverityToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :severity, :integer, :default => 0
  end
end
