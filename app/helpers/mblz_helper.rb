module MblzHelper
  def list title = nil, options = {}
    args = {'data-role' => 'listview',  'data-inset' => 'true', 'data-theme' => 'c'}.merge!(options)
    haml_tag('ul', args) do
      if title
        if title.is_a?(Array)
          title = "#{title.first} <b class='pull-right' style='color:gray'>#{title.last}</b>".html_safe
        end
        haml_tag('li', title, 'data-role' => 'list-divider', 'data-theme': 'c')
      end
      yield
    end
  end

  def list_item object,column
    return if object.send(column).blank?
    render :partial => 'mblz/shared/list_item', :locals => {:object => object, :column => column}
  end

  def navbar
    content_for :navbar, render('navbar')
  end

  def btn_edit link
    content_tag('li', link_to('Edit',link), 'data-icon' => 'grid', 'data-theme' => 'a')
  end
  def btn_list objects
    link = link_to "All #{objects}", eval("mblz_" + objects.downcase + "_path")
    content_tag('li', link, 'data-icon' => 'grid', 'data-theme' => 'd')
  end
  def default_invoice_items_select item
    select_tag "invoice_item[][invoice_item_default_id]",
                 options_for_select([['-Select default-','']] + InvoiceItemDefault.select_options, item.invoice_item_default_id)

  end
  def get_current_invoice_status_for i
    if (@invoice and @invoice.status == i) || (params[:s] and params[:s].to_i == i)
      'ui-btn-active'
    else
      ''
    end
  end

  def iphone?
    request.user_agent.include?('iPhone')
  end

  def ago date, created = "Created"
    content_tag(:span, created + " " +time_ago_in_words(date) + " ago", :title => date.to_s(:long))
  end

  def new_item_link
    img = "<div id='waiting'><img src='/images/icon/wait.gif' title='Updating, please wait'/> Please wait ...</div>"
    link_to "New Item", "#", :id => 'aNewItem', 'data-role' => 'button'
      # :url      => "javascript:console.log('2')",
      #  :update   => '',
      #  :before   => "$('#new_items').append(\"#{img}\")",
      #  :complete => "$('#new_items #waiting').remove();$('#new_items').append(request.responseText);$('#new_items ul').listview();$('#new_items select').selectmenu();$('#new_items input').textinput()",
      #  :html     => {'data-role' => 'button'}
  end

  def status_color(status)
    #  est 
    %w[Red Maroon #999 #333 green Teal][status]
  end

  def colored_status invoice
    content_tag :b, invoice.status_name, :style => "color:#{status_color(invoice.status)}"
  end

  def or_blank(value)
    if value.blank?
      content_tag 'small', BLANK, class: 'text-muted'
    else
      value
    end
  end

  def to_yes_no(bool, colored: true)
   answer =  bool ? 'Yes' : 'No'
   if colored
     answer = "<span class='yes_or_no #{answer.downcase}'>#{answer}</span>".html_safe
   end
   answer
  end

end