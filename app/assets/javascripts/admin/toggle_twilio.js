
$(".twilio_active").on('click', function(){
  $('.after_five').prop('checked', this.checked).checkboxradio("refresh")
  $('.before_five').prop('checked',  this.checked).checkboxradio("refresh") 
  $('.weekend').prop('checked',  this.checked).checkboxradio("refresh")  
})

$(".before_five, .after_five, .weekend").on('click', function(){
  var before   = $('.before_five').is(':checked')
  var after    = $('.after_five').is(':checked') 
  var weekend  = $('.weekend').is(':checked') 
  $('.twilio_active').prop('checked', before || after || weekend).checkboxradio("refresh")
})