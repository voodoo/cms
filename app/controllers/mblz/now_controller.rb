class Mblz::NowController < MblzController

  def index
    @date = Date.parse(params[:d]) if params[:d] rescue nil #munged query?
    @date ||= Date.today
    @yesterday = @date-1
    @tomorrow  = @date+1  
    # TODO: Optimize
    @count   = {
      contacts:         current_site.contacts.recent.count,
      calls:            current_site.incoming_calls.recent.count,
      invoices:         current_site.invoices.recent.count,
      comments:         current_site.comments.recent.count,
      activities:       current_site.activities.recent.count,
      outgoing_calls:   current_site.outgoing_calls.recent.count,
      forms:            current_site.submissions.recent.count
    }      
    if params[:d].present?
      conditions = ["updated_at > ? and updated_at < ?", @yesterday, @tomorrow]
      search     = {:conditions => conditions,:limit => 15, :order => 'updated_at desc'}
      @contacts  = current_site.contacts.where("updated_at > ? and updated_at < ?", @yesterday, @tomorrow)
      @invoices  = current_site.invoices.where("updated_at > ? and updated_at < ?", @yesterday, @tomorrow)
      @calls     = current_site.incoming_calls.where("updated_at > ? and updated_at < ?", @yesterday, @tomorrow)
      @outgoing_calls     = current_site.outgoing_calls.where("updated_at > ? and updated_at < ?", @yesterday, @tomorrow)
      @forms     = current_site.submissions.where("updated_at > ? and updated_at < ?", @yesterday, @tomorrow)      
      render template: '/mblz/now/searched'
   elsif params[:q].present?
      first_last = params[:q].split(' ')
      if first_last.size == 2
        @contacts = current_site.contacts.where("first_name like ? and last_name like ?", "#{first_last[0]}%", "#{first_last[1]}%")
      else 
        @contacts = current_site.contacts.search_for(params[:q]).page(params[:page])
      end
      @calls    = current_site.incoming_calls.search_for(params[:q]).page(params[:page])      
      @outgoing_calls    = current_site.outgoing_calls.search_for(params[:q]).page(params[:page])      

      @forms    = current_site.submissions.search_for(params[:q]).page(params[:page])
      @comments = current_site.comments.search_for(params[:q]).page(params[:page])
      @invoices = []
      render template: '/mblz/now/searched'
    else
      filter = {:limit => 10, :order => 'created_at desc'}
      @emergency_contacts =current_site.contacts.with_priority
      @contacts = (@emergency_contacts + current_site.contacts.limit(10).order('updated_at desc')).uniq
      @invoices = current_site.invoices.limit(10).order('updated_at desc')
      @calls    = current_site.incoming_calls.order("created_at desc").limit(10)
      @outgoing_calls = current_site.outgoing_calls.order("created_at desc").limit(10)
      @forms    = current_site.submissions.order("created_at desc").limit(10)
      @comments = current_site.comments.order("created_at desc").limit(10)

    end
  end

  def console
    @title = 'Phone Console'
    @contacts = current_site.contacts_for_phone_console 
  end

end