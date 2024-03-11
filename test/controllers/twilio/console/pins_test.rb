require "test_helper"

describe Twilios::Console::PinsController do

  before  do
    controller.instance_variable_set(:@current_user, users(:user) )
  end

  describe "asks for a new pin" do

    before do
      get :index, format: :xml
    end

    it "renders index template" do
      must_render_template "index"
    end

    it "asks for new pin" do
      response.body.must_include "new pin to be?"
    end 

    it "has original pin" do
      assert_equal(assigns(:current_user).pin, '1111')
    end

  end

  describe "update the pin" do
    before  do
      post :create, Digits: '1234', format: :xml 
    end

    it "renders update tempate" do  
      must_render_template :create
    end

    it "updates the pin" do
      assert_equal(assigns(:current_user).pin, '1234')
    end


    it "says it was updated" do
      response.body.must_include "has been updated"
    end    

  end    

 
end