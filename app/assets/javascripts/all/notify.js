notifications = function(){
  $(".notification").each(function(i) {
    var $me = $(this);
    if( $me.hasClass("notice")) aclass = "ui-body-suc";
    if( $me.hasClass("alert")) aclass = "ui-body-err";
    $("<div class='ui-loader ui-overlay-shadow ui-bar-a ui-corner-all' style='padding:6px'><p>"+ $me.text() +"</p></div>").css({ 
      "display": "block", 
      "opacity": 0.96, 
      "top": $(window).height()/2 -100
    }).addClass(aclass).appendTo($.mobile.pageContainer).delay( 1800 + (400 * i) ).fadeOut( 1400 + (400*i), function(){
    $(this).remove();
    });
    $me.remove();  
  });
};


notify = function(msg, cls){
  $("<div class='ui-loader ui-overlay-shadow ui-bar-a ui-corner-all'><p><b>"+msg+"</b></b></div>")
  .css({ display: "block", 
    opacity: 0.90, 
    position: "fixed",
    padding: "7px",
    "text-align": "center",
    width: "270px",
    left: ($(window).width() - 284)/2,
    top: $(window).height()/2 })
  .appendTo( $.mobile.pageContainer ).delay( 3500 )
  .fadeOut( 1400, function(){
    $(this).remove();
  });

}
