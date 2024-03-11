class Twilios::Console::ContactsController < Twilios::BaseController

	before_filter :require_console_user, except: :transcription_complete
	before_filter :set_contact, except: :index
  
	def index
    @contacts = current_site.contacts_for_phone_console 
	end

	def action
		@action  = board_options.select{|k,v| k == params[:Digits]}.values.first[:name] rescue nil
		@invoice = @contact.invoices.last # TODO: Beware timing
	  case @action
	    when :call
	      Activity.create!(
	            user_id: @current_user.id,
	            action: "call_contact", 
	            trackable_id: @contact.id,
	            trackable_type: 'Contact', 
	            site_id: current_site.id, 
	            contact_id: @contact.id, 
	            note: "Called contact from phone console"
	        )	    	
	    when :release
	    	if @contact.priority.zero? # must be wanting to mark as received
	    		@received = true
	    		@invoice.update_attribute(:received_by, @current_user)
		      Activity.create!(
		            user_id: @current_user.id,
		            action: "received_by_owner", 
		            trackable_id: @invoice.id,
		            trackable_type: 'Invoice', 
		            site_id: current_site.id, 
		            contact_id: @contact.id, 
		            note: "Invoice Marked as received"
		        )	    		
	    	else
		      @contact.release_priority!
		      Activity.create!(
		            user_id: @current_user.id,
		            action: "release_priority", 
		            trackable_id: @contact.id,
		            trackable_type: 'Contact', 
		            site_id: current_site.id, 
		            contact_id: @contact.id, 
		            note: "Released priority via phone console"
		        )
	      end
      else
	      redirect_to twilios_console_root_path
	  end

	end


  def recording_complete
    @contact.comments.create(site_id: current_site.id, user_id: @current_user.id, title: "Phone console comment", recording_url: params[:RecordingUrl])
    redirect_to twilios_console_contacts_path
  end

  def transcription_complete
    @contact.comments.where("title = ? and recording_url is not null", "Phone console comment").last.update_attribute(:comment, params[:TranscriptionText])
    render nothing: true
  end


	protected

	helper_method :board_options
	def board_options
		{
			"1" => {name: :release, action: "release priority"},
			"2" => {name: :comment, action: "create comment"},
			"3" => {name: :call,    action: "call contact"}
		}
	end

  # def set_current_user
  # 	@current_user =  @call.user_with_pin
  # 	unless @current_user 
  # 		raise ActionController::RoutingError.new('Not Found')
  # 	end
  # end

  def set_contact
  	@contact = current_site.contacts.find(params[:id])
  end

end