class Mblz::WaysController < MblzController
  def index
    @ways = current_site.ways.order('created_at desc').page(params[:page])
  end
  def create
    @way = current_user.ways.new(way_params.merge(site_id: current_site.id))
  	if @way.save
  	  redirect_to mblz_ways_path
  	else
  	  render action: 'new'
  	end
  end
  def new
  	@way = current_user.ways.new
  end

  private

  def way_params
  	params.require(:way).permit!
  end
end
