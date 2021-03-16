function check_item_quantity(el){
	item_id = $('#line_item_item_id').val();
	$.ajax({
		url: "/items/available_quantity",
		type: 'POST',
	    data: {"key": $(el).val(), "id": item_id},
	    dataType: 'script',
		complete: function(data){
			data = JSON.parse(data.responseText);
			if(data["valid"] == true){
				$('#item_quantity_error').hide();
				$('#add_item_submit_btn').prop('disabled', false);
			}else{
				$('#add_item_submit_btn').prop('disabled', true);
				$('#item_quantity_error').html("Quantity should be less than or equal "+data["quantity"]);
				$('#item_quantity_error').show();
			}
		}
	})
}