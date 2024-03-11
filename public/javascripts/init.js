$(function(){
	if($.browser.mozilla && jQuery.fn.autogrow) $('textarea').autogrow();
	if(document.forms.length == 1) {
  	$(document).bind('keydown', 'ctrl+s', function(){
      if(document.forms[0].onsubmit) document.forms[0].onsubmit()
    });	  
	}
})