window.onload = function(){
    var timer = null
    var count = 1
    var email = null

    var wait    = 20 // Seconds
    var seconds = 1000 * wait
    
    $('#selectWho a').on('click', function(e){
      email = $(this).data('email')
      e.preventDefault()
      $('#selectWho').hide()
      $('#showWho').show()
      $('#pinging').html(email)
      send()
      timer = setInterval(send, seconds)
      function send(){
        if(count > 5) { clear(); return}
        $.ajax({
          type: "POST",
          url: '/admin/wheres',
          data: {email: email, count: count},
          success: function(r){
            $('#counter').html(count++)
          }
        });   
      }

    })

    $('#showWho a').on('click', function(e){
      e.preventDefault()
      clear()
    })    

    function reset(){
      count = 1
      email = null
      $('#counter').html(count)
      $('#selectWho').show()
      $('#showWho').hide()    
    }
    function clear(){
      reset()
      clearInterval(timer)
    }

    $.ajaxSetup({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });    
}