module Mblz::PaginatorHelper
  def pager objs
    if objs.current_page < objs.total_pages
      content_tag :a, "More", :href => "?page=#{objs.current_page + 1}&#{current_params}", :class => 'button', "data-role" => 'button', :title => " #{objs.current_page} of #{objs.total_pages} pages. Total found :#{objs.total_entries}."
    end
  end
  def current_params
    pms = []
    for param in params
      "#{param}=#{params[param]}"
    end
    pms.join('&')
  end
end