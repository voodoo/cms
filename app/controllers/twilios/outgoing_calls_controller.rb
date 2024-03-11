class Twilios::OutgoingCallsController < ApplicationController
  layout nil
  skip_before_filter :verify_authenticity_token
  before_filter :set_twilio
  before_filter :set_call


  def create
  end


  protected

  def set_call

    @call = current_site.outgoing_calls.find_by_sid(params[:CallSid])
    @phone   = params[:phone_number]
    unless @call
      @call = current_site.outgoing_calls.create!(
          user_id:        params[:user_id],
          contact_id:     params[:contact_id],
          sid:            params[:CallSid], 
          contact_phone:  @phone,
          status:         [], 
          paths:          []
      )
      

      track_activity @call, "from browser", "create", @call.user

    end
    # Call duration is sent in callback - should be the last event on call
    @call.update_attributes(recording_url: params[:RecordingUrl], :duration => params[:DialCallDuration], :paths => @call.paths.push(request.path), :status => @call.status.push(params[:CallStatus]))

  end

  def set_twilio
    @twilio = current_site.twilio_config
  end


end