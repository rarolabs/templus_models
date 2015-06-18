function permission(){
	$('*[id^="all_"]').on("ifClicked",function(){
		id = $(this).attr("id").split("_")[1];
		if(!$(this).prop('checked')) {
			$("#view_"+id).iCheck('check');
			$("#create_"+id).iCheck('check');
			$("#edit_"+id).iCheck('check');
			$("#destroy_"+id).iCheck('check');
		}else{
			$("#view_"+id).iCheck('uncheck');
			$("#create_"+id).iCheck('uncheck');
			$("#edit_"+id).iCheck('uncheck');
			$("#destroy_"+id).iCheck('uncheck');
		}
	});
	$('*[id^="view_"]').on("ifClicked",function(){
		if($(this).prop('checked')) {
			id = $(this).attr("id").split("_")[1];
			$("#create_"+id).iCheck('uncheck');
			$("#edit_"+id).iCheck('uncheck');
			$("#destroy_"+id).iCheck('uncheck');
			$("#all_"+id).iCheck('uncheck');
		}
	});
	$('*[id^="create_"]').on("ifClicked",function(){
		id = $(this).attr("id").split("_")[1];
		if(!$(this).prop('checked')) {
			$("#view_"+id).iCheck('check');
		}else {
			$("#all_"+id).iCheck('uncheck');
		}
	});
	$('*[id^="edit_"]').on("ifClicked",function(){
		id = $(this).attr("id").split("_")[1];
		if(!$(this).prop('checked')) {
			$("#view_"+id).iCheck('check');
		}else {
			$("#all_"+id).iCheck('uncheck');
		}
	});
	$('*[id^="destroy_"]').on("ifClicked",function(){
		id = $(this).attr("id").split("_")[1];
		if(!$(this).prop('checked')) {
			$("#view_"+id).iCheck('check');
		}else {
			$("#all_"+id).iCheck('uncheck');
		}
	});
}
