class AddPaidToProductInvoice < ActiveRecord::Migration
  def change
    add_column :product_invoices, :paid, :integer, default: 0
  end
end
