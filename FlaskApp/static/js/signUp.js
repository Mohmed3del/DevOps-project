$(function() {
	$('#btnSignUp').click(function() {
		$.ajax({
			url: '/signUp',
			data: $('form').serialize(),
			type: 'POST',
			sucess: function(response) {
				console.log(response);
			},
			error: function(error) {
				console.log(error);
			}
		});
	});
});