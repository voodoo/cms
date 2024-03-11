require "test_helper"

class InvoiceTest < Capybara::Rails::TestCase

  before do
    sign_in_as 'admin', 'secret'
  end

  test "new invoice" do
    visit new_mblz_invoice_path(contact: contacts(:default).id)
    assert_content 'New Invoice'
    within first("ul[@class='invoice-item']") do
    	select('invoice item default name', from: 'invoice_item__invoice_item_default_id')
    	fill_in('invoice_item__price', with: '5')
    end
    click_button 'Create Invoice'
    assert_content '$5.41'
  end 

  test "new invoice throws an error without a contact" do
  	assert_raise ActionView::Template::Error do
    	visit new_mblz_invoice_path
    end
  end 
   
end
