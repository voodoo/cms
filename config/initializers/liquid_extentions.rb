module LiquidExtentions
  class Find < Liquid::Block                                             
    def initialize(markup, tokens, another)
       super 
       @pagename = tokens
    end

    def render(context)       
      pg = $ITE.pages.find_by_path(@pagename)     
      context.merge('page' => pg, 'pages' => pg.children.reject{|c| c.name =~ /^_/ })        
      super(context)#.join('').html_safe
    end    
  end
  class FindAll < Liquid::Block                                             
    def initialize(markup, tokens, another)
       super 
       @pagename = tokens
    end

    def render(context)      
      if pg = $ITE.pages.find_by_path(@pagename)     
        
       # pg.elements.each do |e|  
       #   if e.element_type == 'Date'
       #     pg.attributes.merge(e.name => e.date.to_s(:long))
       #   else                                    
       #      $ITE.logger.debug("------------------#{e.id}-------------------")
       #      pg.attributes.merge(e.name => e.value)
       #   end
       # end
        
        pages = []
        pg.children.each_with_index do |child,idx|
          child.attributes.merge('odd' => idx % 2 == 0)  
          
          #child.elements.each do |e|  
          #  if e.element_type == 'Date'
          #    pages << child.attributes.merge(e.name => e.date.to_s(:long))
          #  else                                    
          #     $ITE.logger.debug("------------------#{e.value}-------------------")
          #    pages << child.attributes.merge(e.name => e.value)
          #  end
          #end
          
          pages << child.attributes
          
        end             
        context.merge('pages' => pages, 'page' => pg.attributes)        
        #cnt = super(context)
        #lp cnt.class
        super(context)#.join('')
      else
        "Page not found  '#{@pagename}'"
      end
    end    
  end
end
module LiquidExtentionedFilters  
  def textilize(input)
    RedCloth.new(input).to_html
  end      
  def gallery sdirectory
      dir = $ITE.folders.find_by_name(sdirectory)  
      unless dir
         return "Directory not found(#{sdirectory})"
      end         
      s = ''
      #s += "<h1>#{sdirectory.capitalize}</h1>" 
      s += '<ul class="simple-gallery">'
      for image in dir.uploads 
        s += "<li><a href='#{image.upload.url}' class='lightbox' title='#{image.title}'><img src='#{image.upload.url(:thumb)}' /></a></li>"
      end
      s += '<div class="clear"></div></ul>'
      s
  end  
  
  def finder spage    

    page = $ITE.pages.find_by_path(spage) 
    
    unless page
       return "'#{spage}' not found"
    end                          
    text    = page.text

    text = Liquid::Template.parse(text).render()
    if page.textile? 
       text = RedCloth.new(text).to_html
    end 
    
    text
  end 

  def to_slug name
    name.to_slug
  end   
  
  def paypal_store folder, price, account = 'elva@integrated-internet.com', tax = 8.5, shipping = 0.0
    dir = $ITE.folders.find_by_name(folder)  
    unless dir
       return "Directory not found('<b>#{folder}</b>')"
    end         
    s = '<ul class="paypal_store">'
    for image in dir.uploads 
      #s += "<li><a href='' class='lightbox' title='#{image.title}'><img src='#{image.upload.url(:small)}' /></a></li>"
      s += %Q[
<li>
<a class="lb" 
href="#{image.upload.url}" 
title="#{image.title}" ><img alt="#{image.title}" src="#{image.upload.url(:small)}"/></a>
<br/>
<form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" style="height:40px">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="elva@integrated-internet.com">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="item_name" value="#{image.title}">
<input type="hidden" name="item_number" value="#{image.title}">
<input type="hidden" name="amount" value="#{price}">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="button_subtype" value="products">
<input type="hidden" name="tax_rate" value="#{tax}">
<input type="hidden" name="shipping" value="#{shipping}">
<input type="hidden" name="add" value="1">
<input type="hidden" name="bn" value="PP-ShopCartBF:btn_cart_LG.gif:NonHostedGuest">
<input type="image" 
src="https://www.paypal.com/en_US/i/btn/btn_cart_LG.gif" 
border="0" name="submit" 
alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form> 
</li>
      ]
    end
    s += '<div class="clear"></div></ul>'
    s
  end 
end

Liquid::Template.register_tag('findall', LiquidExtentions::FindAll)  
Liquid::Template.register_tag('find', LiquidExtentions::Find)  

Liquid::Template.register_filter(LiquidExtentionedFilters)
