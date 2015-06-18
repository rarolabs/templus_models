window.mensagem_success = (str) ->
	toastr.success(str, 'Sucesso!');

window.mensagem_error = (str) ->
	toastr.error(str, 'Erro!');

window.mensagem_notice = (str) ->
	toastr.warning(str, 'Atenção!');

window.mensagem_alert = (str) ->
	toastr.warning(str, 'Atenção!');

window.mensagem_info = (str) ->
	toastr.info(str, 'Informação!');