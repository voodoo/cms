// Update the status of invoice on invoice show
$("#invoice_status input[type='radio']").click(function(){
  $.mobile.loading('show');
  invoice_id = $(this).attr('invoice') 
  $.ajax({
    type: 'POST',
    url: "/mblz/invoices/" + invoice_id + "/update_status",
    data: {status:$(this).val()},
    success: function(data){
      $.mobile.loading('hide');
      //$('#invoice_status').show('slow');
      notify(data)
      if(data.indexOf('Work') != -1){
        setTimeout(function(){
          document.location = "/mblz/invoices/" + invoice_id + "/edit"
        }, 1000)        
      }    
    }
  });
})