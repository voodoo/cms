$('#frmEditPriority').on('change', function(el){
  $.ajax({type:'PUT', url: this.action , data: $(this).serialize() })
    .success(function(s){
    	notify(s)
    })
})