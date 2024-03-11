require "test_helper"

class ContactTest < Capybara::Rails::TestCase

  before do
    sign_in_as 'admin', 'secret'
  end

  test "new contact with valid fields" do
    visit new_mblz_contact_path
    fill_in "contact[first_name]", with: 'first name'
    fill_in "contact[last_name]", with: 'last name'
    fill_in "contact[phone]", with: '2222222222'
    fill_in "contact[email]", with: 'p@u.com'
    fill_in "contact[city]", with: 'san antonio'
    fill_in "contact[street]", with: '123 street'
    click_button 'Create Contact'
    assert_content 'Created Contact'
  end 

  test "new contact without valid fields" do
    visit new_mblz_contact_path
    assert_content 'New Contact'
    click_button 'Create Contact'
    assert_content 'problems with the following fields'
  end 


end
