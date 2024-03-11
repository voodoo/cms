class AddWorkDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :work_date, :date
    add_column :invoices, :work_note, :string
  end
end
