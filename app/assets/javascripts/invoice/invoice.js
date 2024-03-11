L = console.log.bind(console);

spinner = function(msg){
  return '<h4><i class="fa fa-spinner fa-spin fa-2x"></i>&nbsp;' + msg + '</h4>'
}

waiting = function(id,msg){
  $(id).html(spinner(msg))
}

Invoice = {
  initUI: function(){
    $('.btn-yes-no').on('click', function(e){
      e.preventDefault()
      if($(e.target).text().indexOf('Yes') != -1){
        $('#divYes').slideDown()
        $('#divNo').slideUp()
      } else {
        $('#divNo').slideDown()
        $('#divYes').slideUp()
      }
      $('#btnsYesOrNo').slideUp()
    })

    $('.btn-cancel').on('click', function(e){
      e.preventDefault()
      $('#divYes').slideUp()
      $('#divNo').slideUp()
      $('#btnsYesOrNo').slideDown()
    })    
  }
}


