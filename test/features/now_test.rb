require "test_helper"

class NowTest < Capybara::Rails::TestCase

  before do
    sign_in_as 'admin', 'secret'
  end

  test "contacts" do
    assert_content 'priority_contact_last_name'
    assert_content 'default_contact_last_name'
    page.first(:xpath, "//a", text: 'priority_contact_last_name').click
    assert_content 'priority_contact_last_name'
    assert(page.has_xpath?('//h1', text: 'Contact'))
  end  

  test "all contacts" do
    
    click_link 'Contacts', match: :first
    assert(page.has_xpath?('//h1', text: 'Contacts'))
  end

  # Moved invoices out of now
  # test "shows invoices" do    
  #   save_and_open_page
  #   assert_content 'Invoices'
  #   assert_content 122
  #   page.find(:xpath, "//a[contains(@href,'mblz/invoices')]", text: 'priority_contact_last_name').click
  #   assert_content 'priority_contact_last_name'
  #   save_and_open_page
  #   assert(page.has_xpath?('//h1', text: 'Estimate'), "Shows invoice h1")
  #   assert(page.has_xpath?('//h3', text: '5.68'), "Shows total")
  # end 

  test "shows all invoice" do
    click_link 'Invoices'
    assert(page.has_xpath?('//h1', text: 'Invoices'))
  end

  
end
