require "test_helper"

describe Twilios::Console::MessagesController do

  describe "list messages" do
    before do
      get :index, format: :xml
    end

    it "renders index template" do
      must_render_template "index"
    end
    it "says the message" do
      response.body.must_include "http:"
    end 

    it "only shows one console message"   do
      assert_equal(1, assigns(:messages).count)
    end
  end

  describe "non released message actions" do
    before  do
      @message = incoming_calls(:with_message_not_released)  
    end

    it "renders update tempate" do  
      post :create, id: @message.id, format: :xml  
      must_render_template :create
    end

    it "releases the message" do
      assert_difference 'sites(:default).incoming_calls.console_messages.count', -1 do
        post :create, Digits: '1', id: @message.id, format: :xml
      end
    end


    it "says it was releases" do
      post :create, Digits: '1', id: @message.id, format: :xml
      response.body.must_include "Message released"
    end    

  end    

  describe "multiple messages" do
    before  do
      @site = sites(:default)
      @site.incoming_calls.create!(recorded_message_url: "http://twilio.com/messages?with_message_not_released2.mp3", status: [], paths:[])      
    end

    it "has the right count" do  
      get :index, format: :xml
      assert_equal(assigns(:messages).count, 2)
    end

    it "skips a message" do
      @message = incoming_calls(:with_message_not_released) 
      # assert_difference 'assigns(:messages).count', -1 do
      #   post :create, Digits: '2', id: @message.id, format: :xml
      # end
      post :create, Digits: '2', id: @message.id, format: :xml
      assert_equal(assigns(:messages).count, 1)
      must_render_template "create"
    end    

  end    
 
end