
$(function(){
	var u = $('#user_session_login');
	var p = $('#user_session_password');
	setTimeout(function(){
		if(u.val()){
		  console.log('p')
		  $('#user_session_password').focus();	
		}else{
		  console.log('u')
		  $('#user_session_login').focus();
		}		
	}, 500)
	$('#errorExplanation').addClass('ui-body-e').addClass('rounded').css('padding', '10px').css('padding-top',0);

})