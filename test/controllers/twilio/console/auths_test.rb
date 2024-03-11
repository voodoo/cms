require "test_helper"

describe Twilios::Console::AuthsController do


  describe "valid user phone and creds" do
    before do
      post :create, Digits: "1111", Caller: '2105551111', format: :xml
    end

    it "renders auth template" do
      must_render_template "create"
    end

    it "redirects" do
      response.body.must_include "Redirect"
    end

    it "redirects to console board" do
      response.body.must_include "/twilios/console"
    end    

    it 'instantiates an auth user' do
      assert_equal(assigns(:authed), users(:user))
    end
  end  

  describe "INVALID creds" do
    before do
      post :create, Digits: "2222", Caller: '2105551111', format: :xml
    end

    it "renders auth template" do
      must_render_template "create"
    end

    it "pin does not match" do
      response.body.must_include "Pin did not match"
    end
    it "redirects back to auth" do
      response.body.must_include "/twilios/console/auths"
    end    
  end   
end