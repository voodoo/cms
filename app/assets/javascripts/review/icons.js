$('ul#divIcons li').on('click', function(e){
	e.preventDefault()
  $('ul#divIcons li.icon').buttonMarkup({icon: 'arrow-r', theme: 'c'})//.attr("data-theme", "c")
  
  //$('#divIcons ul').listview('refresh')

  //$(this).attr("data-theme", "b");
  $(this).buttonMarkup({ icon: "check", theme: 'b'})

  $('#review_icon').val($(this).data('dicon'))

  //setTimeout( function(){ log(1) ; $('#divIcons ul').listview('refresh')}, 1000)
})

// log($('ul#divIcons li[data-dicon=heart]'))
// $($('ul#divIcons li[data-dicon=heart]')).buttonMarkup({ icon: "check" }).attr("data-theme", "b")