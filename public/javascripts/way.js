$(function(){
  $('#where_are_you_from').val(Phones.from());
  $('#where_are_you_to').val(Phones.to());
})
function validateWhereAreYouForm(){
  var to   = $('#where_are_you_to').val();
  var from = $('#where_are_you_from').val();

  if(Phones.valid(to) && Phones.valid(from)){
	Phones.from(from);
	Phones.to(to);
	return true;
  } else {
	alert('Please fill in valid phone numbers');
	return false;
  }
}
function setHereIAm(){
	if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(function(position){
	  		  $('#where_are_you_response_lat').val(position.coords.latitude);
	  		  $('#where_are_you_response_lng').val(position.coords.longitude);
	 	});
	  
	}else{
	 alert('Geolocation not supported in this browser');
	}	
}
function validateHereIAmForm(){
	if($('#where_are_you_response_lat').val() == '' || $('#where_are_you_response_lng').val() == '') {
		alert('Please reload - your location was not set');
		return false
	}else{
		return true;
	}
}

var VALID_PHONE = /\d\d\d-\d\d\d-\d\d\d\d/
Phones = {
	html5:function(){
		return localStorage != undefined
	},
	from: function(from_phone){
		if(!this.html5) return false
		if(from_phone != undefined) 
		  localStorage.setItem('from_phone', from_phone)
		return localStorage.from_phone
	},
	to: function(to_phone){
		if(!this.html5) return false
		if(to_phone != undefined) 
		  localStorage.setItem('to_phone', to_phone)
		return localStorage.to_phone
	},	
	valid: function(phone){
		return phone.match(VALID_PHONE);
	}
}



// // $(function(){
// //  $('#where_are_you')	
// // });
// //localStorage.clear();
// 
// function setWhere(){
// 	if (navigator.geolocation) {
// 	   navigator.geolocation.getCurrentPosition(function(position){
//    		  $('#where_are_you_response_lat').val(position.coords.latitude);
//    		  $('#where_are_you_response_lng').val(position.coords.longitude);
// 	 	});
//     }else{
// 	 alert('Geolocation not supported in this browser');
// 	}
// 
// }
// 
// 
// function setNewForm(){
//   $('#btnNewWhereAreYou').click(function(){  	
//   	if(Phones.valid($('#where_are_you_to').val()) && Phones.valid($('#where_are_you_from').val())){
// 	  Phones.set($('#where_are_you_to').val());
// 	  Phones.from($('#where_are_you_from').val());
// 	  //alert(Phones.get());	
//   	  //$('#new_where_are_you').submit();
//   	}  
//   	else
//   	{
//   	  alert('Please fill in a proper To: and From: phone number');
//   	}
//   });
// 
//   var from = Phones.from()
//   if(from){
// 	$('#where_are_you_from').val(from);
//   }
//   var phones = Phones.get();
//   if(phones){
// 	$('#where_are_you_to').val(Phones.last())
//   }
//   if(phones && phones.length > 2){
// 	//setPhoneSelect();
//   }	
//   function setPhoneSelect(){
// 	$('#divSlcTo').show();
// 	var slc = $('#slcTo')
// 	var phones = Phones.get();//.reverse();
// 	for(var i = 0 ; i < phones.length ; i++){
// 		slc.append("<option>"  + phones[i] + "</option>")
// 	}
//   }
// }

