require "test_helper"

describe Twilios::OutgoingCallsController do

  describe "POST :create " do
    before do
      post :create, contact_id: contacts(:default).id, user_id: users(:admin).id, phone_number: contacts(:default).phone, format: :xml
    end

    it "renders create" do
      must_render_template "create"
    end

    it "should contain site phone" do
      response.body.must_include "callerId=\"21011112222\""
    end
    it "should contain contact phone" do
      response.body.must_include "<Number>2105553333</Number>"
    end

    it "assign the user" do
      assert assigns(:call).user, users(:admin)
    end

    it "assign the contact" do
      assert assigns(:call).contact, contacts(:default)
    end
  end

  # describe "User calling" do
  #   before do
  #     post :create, Caller: 2105551111 , format: :xml
  #   end

  #   it "does not contain the owner phone" do
  #     response.body.wont_include '8675309'
  #   end

  #   it "renders recognized_user_phone" do
  #     must_render_template "recognized_user_phone"
  #   end    

  #   it "redirects to auth" do
  #     response.body.must_include "<Redirect>/twilios/console/auths/pin"
  #   end

  #   it 'assigns the call to the user' do
  #     assert_not_nil assigns(:call).user_id
  #   end
  # end  

  # describe "User calling but no pin" do
  #   before do
  #     post :create, Caller: 2105551112 , format: :xml
  #   end

  #   it "renders create" do
  #     must_render_template "create"
  #   end    
  # end    
end