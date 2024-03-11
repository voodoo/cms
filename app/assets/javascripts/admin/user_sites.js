$(function(){
  $("#fieldset_user_sites input[type=checkbox]").unbind('click').click(function(event){
    $.mobile.showPageLoadingMsg();
    var user = $(this).data('user');
    var site = $(this).data('site');
    console.log(user,site);
    $.ajax({
      type: "POST",
      url: '/admin/users/' + user + '/update_site_access?site=' + site,
      success: function(s){
        $.mobile.hidePageLoadingMsg(); 
        notify(s)
      }    
    });
  })  
})

