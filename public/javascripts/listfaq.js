$(function(){
	$('#listfaq .linkslide').click(function(){
	  $(this).parent().find('.slide').slideToggle('slow');
	  $(this).toggleClass('active');
	  return false;
	});	
})
