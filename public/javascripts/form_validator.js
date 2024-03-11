// dependency : jquery
function Validate(Form){      
	 var e = Form.elements
	 var errors = []
	 for(var i = 0 ; i < e.length ; i++){
	    
	   if(e[i].type == 'text' || e[i].type == 'textarea' || e[i].type == 'select-one'){
	     $(e[i]).parent().removeClass('error_field')
	     if(!e[i].getAttribute('notrequired')){
	      if(e[i].value == ''){
	        errors.push(e[i])
	      }
	     }
	   }
	 }
	 if(errors.length > 0){
	   var s = ''
	   jQuery.each(errors, function(){
	      $(this).parent().addClass('error_field')
	 		  s += "\n\t" + this.getAttribute('title')
	   })
	   alert('The following for fields are required.\n\n' + s + '\n\nPlease input required values.')
	    return false 
	 }

	 return true	

}