class Mblz::OutgoingCallsController < MblzController
  def index
    @outgoing_calls = current_site.outgoing_calls.order('created_at desc').page(params[:page])
  end
  def show
    @call = current_site.outgoing_calls.find(params[:id])
  end
end