require "test_helper"

describe Twilios::CallsController do

  describe "POST :create unrecognized phone" do
    before do
      post :create, Caller: 8005551111, format: :xml
    end

    it "renders create" do
      must_render_template "create"
    end

    it "responds with success" do
      must_respond_with :success
    end

    it "contains the owner phone" do
    	response.body.must_include '8675309'
    end

    it 'does not assign the call to a user' do
      assert_nil assigns(:call).user_id
    end

  end

  describe "User calling" do
    before do
      post :create, Caller: 2105551111 , format: :xml
    end

    it "does not contain the owner phone" do
      response.body.wont_include '8675309'
    end

    it "renders recognized_user_phone" do
      must_render_template "recognized_user_phone"
    end    

    it "redirects to auth" do
      response.body.must_include "/twilios/console/auths"
    end

    it 'assigns the call to the user' do
      assert_not_nil assigns(:call).user_id
    end
  end  

  describe "User calling but no pin" do
    before do
      post :create, Caller: 2105551112 , format: :xml
    end

    it "renders create" do
      must_render_template "create"
    end    
  end    
end