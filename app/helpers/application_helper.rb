module ApplicationHelper

  def mobile?
    user_agent = UserAgent.parse(request.user_agent)
    user_agent.mobile?
  end

  def js_asset *args
    s = ''
    for arg in args
      s += javascript_include_tag("#{ASSETS_HOST}/#{arg}.js") 
    end   
    s.html_safe
  end

  def css_asset *args
    s = ''
    for arg in args
      s += stylesheet_link_tag("#{ASSETS_HOST}/#{arg}.css") 
    end   
    s.html_safe
  end

  def title message
    @title = message
    @head  = message
  end 


  def show_flash_message(options={})
    return if flash.empty?
    
    html = content_tag(:div, 
                       flash.collect{ |key,msg| 
                         content_tag(:div, msg, :class => "message #{key}") },
                       :id => 'flash-message', :onclick => '$(this).hide()')
    if options.key?(:fade)
      html << content_tag(:script, 
                          "setTimeout(\"$('#flash-message').fade()\",#{options[:fade]*1000})",
                          :type => 'text/javascript')
    end
    html
  end 

  def cms_page_crumb
    return '' if @page.nil? or @page.parent.nil?
    crumb = [@page.title]
    page  = @page.parent
    while page.parent  do
      crumb << link_to(page.title, edit_cms_page_path(page))
      page = page.parent
    end
    crumb << link_to(@current_site.root_page.title, cms_pages_path)
    lis = crumb.map{|c| "<li>#{c}</li>"}
    content_tag "ul", lis.reverse.join(''), :id => "crumbs"
  end 

  def to_host_path subdomain = nil, path = nil
    subdomain += '.' if subdomain
    "https://#{subdomain}#{request.host}#{path}" 
  end
  
end
