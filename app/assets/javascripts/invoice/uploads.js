  
function resizeFiles(files){
	for(var i = 0 ; i < files.length ; i++){
		canvasResize(files[i], {
    	width: 500,
    	height: 0,
    	crop: false,
    	quality: 80,
    	//rotate: 90,
    	callback: function(data, width, height, file) {
    		var img = new Image
    		img.src = data
    		img.name= file.name
    		img.title=img.width + "/" + img.height
    		$('#filesInfo').append(img).append("<p><input type='text' name='title[]' placeholder='Title'/></p>")
    	}
    });
    //};		
	}
}

function uploadFiles(invoiceId,before_or_after){
	var fd     = new FormData();
	var titles = $('#filesInfo input')
	$("#filesInfo img").each(function(i){
		var f = this.src //canvasResize('dataURLtoBlob', this.src);
		console.log(this.name)
		//f.name=this.name;
		fd.append('files[]',f);
		fd.append('names[]',this.name);
		fd.append('titles[]', titles[i].value)
	})

	var xhr = new XMLHttpRequest();
	xhr.open('POST', '/mblz/invoices/' + invoiceId + '/attachments?ba=' + before_or_after, true);
	xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
	xhr.setRequestHeader("pragma", "no-cache");	
  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
  xhr.addEventListener("load", function(e) {
  	document.location = "/mblz/invoices/" + invoiceId
  })
	xhr.send(fd);


}
