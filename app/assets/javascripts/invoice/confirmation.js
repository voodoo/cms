//$('#estimate_confirmation_desired_appointment_date').datepicker()

Invoice.initUI()




$('#frm-confirmation').validator().on('submit', function(e){
  if (e.isDefaultPrevented()) {
    alert("Please fill out all required fields - highlighted in red")
  } else {
  

  e.preventDefault()


  var token                    = $('#estimate_confirmation_token').val()
  var yes_or_no                = 1
  var desired_appointment_date = $('#estimate_confirmation_desired_appointment_date').val()
  var details                  = $('#estimate_confirmation_details').val()

  var dContainer               = $('#confirmation-container')




  // Fixed last bug /sigh
  var data = {estimate_confirmation:{yes_or_no: yes_or_no, desired_appointment_date: desired_appointment_date, details: details}}
  
  var url = $INVOICE_URL + "/estimate_confirmations"

  waiting('#confirmation-container', 'Submitting. Please wait...')

  $.ajax({
    type: "POST",
    url: url,
    data: data, //$(F).serialize(),
    success: function(msg){
       if(parseInt(msg)!=0)
       {

         dContainer.fadeOut('slow').html(msg).fadeIn()
       }
    },
    error: function(){
      dContainer.html('Failed - we are sorry but something went wrong.').fadeIn()
    }
   });
  } 
})


$('#frm-confirmation-cancel').validator().on('submit', function(e){
  if (e.isDefaultPrevented()) {
    alert("Please fill out all required fields - highlighted in red")
  } else {
    
  e.preventDefault()
  var yes_or_no                = 0
  var care_to_share            = $('#estimate_confirmation_care_to_share').val()
  var divContainer               = $('#confirmation-container')

  // Fixed last bug /sigh
  var data = {estimate_confirmation:{yes_or_no: yes_or_no, care_to_share: care_to_share}}
  
  var url = $INVOICE_URL + "/estimate_confirmations"

   waiting('#confirmation-container', 'Submitting. Please wait...')

  $.ajax({
    type: "POST",
    url: url,
    data: data, //$(F).serialize(),
    success: function(msg){
      divContainer.fadeOut('slow').html(msg).fadeIn()
    },
    error: function(){
      divContainer.html('Failed - we are sorry but something went wrong.').fadeIn()
    }
   });
  } 
})