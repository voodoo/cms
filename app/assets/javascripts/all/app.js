var $SPINNER = "<img src='https://assets.integrated-internet.com/img/icons/wait.gif' title='Updating, please wait'/>"

function log(msg){
  if(typeof console != 'undefined')
    console.log(msg)
}

function toggleSearch(){
  var page = $($.mobile.activePage);
  var div = page.find('.clsSearch');
  if(div.is(':hidden')){
    div.show(0, function(){
      div.find('input[data-type=search]').select().focus()
    });
  } else {
    div.hide(0);
  }
    
  window.scrollTo(0,1);

}
