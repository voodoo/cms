class Twilios::BaseController < ApplicationController
  layout nil
  skip_before_filter :verify_authenticity_token
  before_filter :set_twilio
  before_filter :set_call
  before_filter :set_format


  protected



  def set_call
    @call = @site.incoming_calls.find_by_sid(params[:ParentCallSid] || params[:CallSid])
    unless @call
      @call = current_site.incoming_calls.create!(
          :sid          => params[:CallSid], 
          :calling      => params[:Caller],
          :city         => params[:CallerCity], 
          :state        => params[:CallerState], 
          :zip          => params[:CallerZip],
          :session      => {}, 
          :status       => [], 
          :paths        => [],
          :caller_name  => params[:CallerName],
          :called_phones=> @phones
      )
      
       
      formatted_phones = @phones.map(&:to_phone).join(', ')

      via = formatted_phones.blank? ? "" : "via phones #{formatted_phones}"
      track_activity @call, "#{params[:Caller].to_s.to_phone} calling #{params[:Called].to_s.to_phone} #{via}", "create", @call.user

    end
    # Call duration is sent in callback - should be the last event on call
    @call.update_attributes(recording_url: params[:RecordingUrl], :duration => params[:CallDuration], :paths => @call.paths.push(request.path), :status => @call.status.push(params[:CallStatus]))

    # if params[:CallStatus].to_s.include?('completed') and !@twilio.call_ii?

    #   body = [
    #       "#{@site.sub_host}/mblz/incoming_calls/#{@call.id}", 
    #       "#{@call.calling} / #{@call.caller_name}",
    #       "Answered by: #{@call.answered_by}",
    #       "Duration: #{@call.duration}"
    #     ].join("\n")
    #   Twilio::SMS.create to:    APP_CONFIG[:phone], 
    #                      from:  @twilio.incoming_phone,
    #                      body:  body
      
    # end

  end

  def set_twilio
    @site   = current_site
    @twilio = @site.twilio_config
    @phones = @site.callable_phones
  end

  def require_console_user
    return @current_user if @current_user 
    unless session[:current_user_id]
      render template: '/twilios/console/auths'
    else
      @current_user = current_site.users.find(session[:current_user_id])
    end
  end  

  def set_format
    request.format = 'xml'
  end
  

end