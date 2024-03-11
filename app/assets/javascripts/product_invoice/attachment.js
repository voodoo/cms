function resizeFile(files){
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
    		$('#img_product_image').attr('src', img.src)
    		uploadFile(img)
    		//$('#filesInfo').append(img).append("<p><input type='text' name='title[]' placeholder='Title'/></p>")
    	}
    });
    //};		
	}
}

function uploadFile(img){
	var fd     = new FormData();
      fd.append('image',img.src);
      fd.append('name',img.name);

	var xhr = new XMLHttpRequest();
	xhr.open('POST', '/mblz/products/' + $PRODUCT_ID + '/upload_image')
	xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
	xhr.setRequestHeader("pragma", "no-cache");	
  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
  xhr.addEventListener("load", function(e) {
  	//log('done')
  	//document.location = "/mblz/invoices/" + invoiceId
  })
	xhr.send(fd);


}
