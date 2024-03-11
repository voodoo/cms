require "test_helper"

describe Twilios::Console::ContactsController do

  before do
    controller.instance_variable_set( :@current_user, users(:user) )
  end


  describe "contact actions (priority)"  do

    before do
      @contact = sites(:default).contacts.with_priority.first
    end

    describe "POST :action = call(1)" do

      before do
        post :action, id: @contact.id, Digits: "1", format: :xml
      end

      it "renders action tempate" do
        must_render_template "action"
      end

      it "has a priority contact" do
        response.body.must_include "2105551212"      
      end

      it "creates the right activity" do
        assert_equal Activity.last.action, "call_contact"
      end     
    end  


    describe "POST :action = release(2)" do

      it "creates an activity" do
        assert_difference 'Activity.count', 2 do #includes the incoming_call activity
          post :action, id: @contact.id, Digits: "2", format: :xml
        end
      end


      it "creates the right activity" do
          post :action, id: @contact.id, Digits: "2", format: :xml

          assert_equal Activity.last.action, "release_priority"
      end



      it "updates priority" do
        post :action, id: @contact.id, Digits: "2", format: :xml
        assert_equal sites(:default).contacts.with_priority.count, 0
      end    

      it "releases priority contact" do
        post :action, id: @contact.id, Digits: "2", format: :xml
        response.body.must_include "Released Priority"      
      end
     
    end  


    describe "POST :action = comment(3)" do

      it "creates the right activity" do
        post :action, id: @contact.id, Digits: "3", format: :xml
        response.body.must_include 'Record'
      end

     
    end  

    describe "POST :action = unknown" do

      before do
        post :action, id: @contact.id, Digits: "4", format: :xml
      end

      it "unknown entry found" do
        response.body.must_include twilios_console_root_path   
      end
     
    end  
 
    describe "POST :recording_complete" do
      it "creates a comment" do
        assert_difference 'Comment.count' do #includes the incoming_call activity
          post :recording_complete, id: @contact.id, RecordingUrl: "http://someurl", format: :xml
        end
      end
    end  

    describe "POST :transcription_complete" do
      before do
        post :recording_complete, id: @contact.id, RecordingUrl: "http://someurl", format: :xml
      end

      it "updates the comment" do
        post :transcription_complete, id: @contact.id, TranscriptionText: "some text was said", format: :xml
        @comment = sites(:default).comments.last
        assert_equal @comment.title, "Phone console comment"
        assert_equal @comment.comment, "some text was said"
        assert_template nil
      end
    end   

  end

  describe "contacts with non-received invoices"  do

      describe "POST :action = release(2) == mark as received" do

        before do
          @contact = contacts(:default)
          @contact.invoices.last.update_attribute(:received_by, nil)
          post :action, id: @contact.id, Digits: "2", format: :xml
        end

        it "creates the right activity" do
          assert_equal Activity.last.action, "received_by_owner"
        end 

        it "says it was marked" do
          response.body.must_include "Marked as received"      
        end        

      end  

  end  
 
end