require "test_helper"

describe Twilios::Console::BoardsController do
  before  do
    controller.instance_variable_set( :@current_user, users(:user) )    
  end
  describe "board index" do
    before do
      get :index,  format: :xml
    end

    it "renders index tempate" do    
      must_render_template :index
    end


    it "says the number of contacts" do    
      response.body.must_include "1 contact"
    end

    it "says the number of messages" do    
      response.body.must_include "1 message"
    end

    it "user is not asked to change greeting" do      
      response.body.wont_include "Press 5"
    end 
     
  end

  describe "board action" do

    it "renders create tempate" do  
      post :create, format: :xml  
      must_render_template :create
    end

    it "redirects to messages" do    
      post :create, Digits: '1', format: :xml
      response.body.must_include "messages"
    end

    it "redirects to contacts" do    
      post :create, Digits: '2', format: :xml
      response.body.must_include "contacts"
    end

    it "redirects to pins" do    
      post :create, Digits: '4', format: :xml
      response.body.must_include "pins"
    end    

    it "redirects to greeting" do    
      post :create, Digits: '5', format: :xml
      response.body.must_include "greetings"
    end       
 
  end  
  describe "owner manager board index" do
    before do
      controller.instance_variable_set( :@current_user, users(:owner) ) 
      get :index,  format: :xml
    end
    it "owner / manager is asked to change greeting" do      
      controller.instance_variable_set( :@current_user, users(:owner) ) 
      response.body.must_include "Press 5"
    end      
  end

end