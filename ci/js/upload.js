$(function(){
			
	 $('.progressuploader').ajaxForm({
	 		beforeSend: function() {
	 			  $(".progress").show();	
				  $(".progress .bar").css("width", "0%");
			},
		    uploadProgress: function(event, position, total, percentComplete) {
			     var percentVal = percentComplete + '%';
		         $(".progress .bar").css("width", percentVal);
		    },
			complete: function(xhr) {
				//status.html(xhr.responseText);
				$(".uploadfield").val("");
				$("#upload_success").show();
				$("#upload_success").text(xhr.responseText);
				$(".progress .bar").css("width", "100%");
				$(".progress").hide();	
					
			}
        }); 
        
       
});