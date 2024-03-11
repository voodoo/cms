
function aNewItem(){
    var page = $($.mobile.activePage);
    $.ajax({
      type: 'GET',
      url: "/mblz/invoices/item",
      data: {},
      beforeSend: function(){
        $('#spinner').html($SPINNER);
      },
      success: function(data){
        page.find('#newItems').append(data);
        page.find('#newItems ul').listview();
        page.find('#newItems ul select').selectmenu();
        page.find('#newItems ul input').textinput();
        page.find('#newItems ul textarea').textinput();
        page.find('#spinner').html('');
      }
    }); 
}
function aNewName(){
  var page = $($.mobile.activePage);  
  page.find('li.new_item_name').toggle('slide')
}