$('a.addProduct').on('click', function(e){
  var product_id = $(this).data('product-id')
  $("input[data-type='search']").val('')
  $("ul#newItemFilter:jqmData(role='listview')").children().addClass('ui-screen-hidden');
  aNewItem(product_id)
  e.preventDefault()
})

function aNewItem(product_id){
    var page = $($.mobile.activePage);
    $.ajax({
      type: 'GET',
      url: "/mblz/product_invoices/item",
      data: {product_id: product_id},
      beforeSend: function(){
        $('#spinner').html($SPINNER);
      },
      success: function(data){
        // console.log(data)
        // console.log(page.find('#newItems').html())
        page.find('#newItems').prepend(data);
        page.find('#newItems ul').listview();
        page.find('#newItems ul select').selectmenu();
        page.find('#newItems ul input').textinput();
        page.find('#newItems ul textarea').textinput();
        page.find('#spinner').html('');
      }
    }); 
}
// function aNewName(){
//   var page = $($.mobile.activePage);  
//   page.find('li.new_item_name').toggle('slide')
// }