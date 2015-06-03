$(document).ready(function (){
	$("select[id$='_estado']").on('change', function() {
		$.getJSON('/api/cidades/busca?estado=' + $(this).val(), {
			format: 'json'
		}, function(data) {
			var i, options;
			options = "";
			i = 0;
			while (i < data.length) {
				options += "<option value='" + data[i].id + "'>" + data[i].nome + "</option>";
				i++;
			}
			$("select[id$='cidade_id']").html(options).show();
			$("select[id$='cidade_id']").trigger('select');
		});
	});
});