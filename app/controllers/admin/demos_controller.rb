class Admin::DemosController < MblzController

  def index
    @demos = Demo.order(:created_at => 'desc')
  end

  def new
    @demo = Demo.new
  end

  def create
    @demo = Demo.new(demo_params.merge(created_by_id: current_user.id, :site_id => current_site.id))
    if @demo.save
      redirect_to admin_demo_path(@demo), :notice => 'Demo site created'
    else
      #flash.now[:warn] = 'Failed creation'
      render action: 'new'
    end
  end

  def show
     @demo = Demo.find(params[:id])
  end

  def destroy
    demo = Demo.find(params[:id])
    demo.destroy
    redirect_to admin_demos_path
  end

  private

  def demo_params
    params.require(:demo).permit!
  end

end
