require "test_helper"

describe Twilios::Console::GreetingsController do

  before  do
    controller.instance_variable_set(:@current_user, users(:user) )
  end

  describe "greetings board" do

    before do
      get :index
    end

    it "renders" do
      must_render_template "index"
    end

    it "says greeting" do
      response.body.must_include "greeting prompt"
    end 


  end

  describe "greetings actions" do

    it "says" do
      post :create, Digits: '1'
      response.body.must_include "Say"
      response.body.wont_include "Record"
    end

    it "plays" do
      sites(:default).twilio_config.update_attribute(:leave_message,'http://twilio.com/greeting.mp3')
      post :create, Digits: '1'
      response.body.must_include "Play"
    end


    it "records" do
      post :create, Digits: '2'
      response.body.must_include "Record"
    end

    it "updates" do
      post :recorded, RecordingUrl: 'http://twilio.com/greeting.mp3'
      sites(:default).twilio_config.leave_message.must_include('http')
    end

  end
 
end