function check_password_confirmation(){
	var pass = $('#user_password').val();
	var passConf = $('#user_password_confirmation').val();
	if($('#member_form').valid()){
		if(pass == passConf){
			$('#password-confirmation-error').hide();
			$('#member_form').submit();
		}else{
			$('#password-confirmation-error').show();
		}
	}
}