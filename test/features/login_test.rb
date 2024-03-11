require "test_helper"

class LoginTest < Capybara::Rails::TestCase

  test "logging in" do
    sign_in_as 'admin', 'secret'
    assert_content 'Successfully logged in'
  end 

  test "failed logging in" do
    sign_in_as 'admin', 'INCORRECT'
    #save_and_open_page
    assert_content 'Failed'
  end  


  test "root should enforce login" do
    visit root_path
    assert_content "Email or User Name"
  end     
end
