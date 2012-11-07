
$(document).ready(function() {
	
	$("#signup").validate({
		rules: {
			"terms": {
				required: true
			},
		},
		messages: {
			"terms":{
				required: "Por favor, aceite nossos termos"
			},
		}
	});
});