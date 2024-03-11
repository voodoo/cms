class Mblz::IncomingCallsController < MblzController
  
  def index
    @calls = current_site.incoming_calls.order('created_at desc')
    case params[:f]
      when 'a'
        @calls = @calls.where("recording_url is not null")
      when 'm'
        @calls = @calls.where("recorded_message_url is not null")
    end
    @calls = @calls.page(params[:page])
  end

  def show
    if params[:id] =~ /^\d+$/
      @call = current_site.incoming_calls.find(params[:id])
    else
      @call = current_site.incoming_calls.find_by_sid(params[:id])
    end
  end

  def destroy
    current_site.incoming_calls.find(params[:id]).destroy
    flash[:notice] = "Call was deleted"
    redirect_to mblz_incoming_calls_path
  end

  def release
    ic = current_site.incoming_calls.find(params[:id])
    bool = !ic.released_from_console
    ic.update_attribute(:released_from_console, bool)
    flash[:notice] = "Changed call in phone console"
    redirect_to mblz_incoming_call_path(ic)
  end
  
end