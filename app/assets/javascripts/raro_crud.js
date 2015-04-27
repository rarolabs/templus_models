//= require permissoes

function atualiza_campos_crud(){
	$('.datepicker').datepicker({
		todayBtn: "linked",
		keyboardNavigation: false,
		forceParse: false,
		calendarWeeks: true,
		autoclose: true
	});

	$('.i-checks').iCheck({
		checkboxClass: 'icheckbox_square-green',
		radioClass: 'iradio_square-green'
	});


	$('.raro_date_range').daterangepicker({
		format: 'DD/MM/YYYY',
		ranges: {
			'Hoje': [moment(), moment()],
			'Ontem': [moment().subtract('days', 1), moment().subtract('days', 1)],
			'Últimos 7 dias': [moment().subtract('days', 6), moment()],
			'Últimos 30 dias': [moment().subtract('days', 29), moment()],
			'Este Mês': [moment().startOf('month'), moment().endOf('month')],
			'Mês Passado': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
		},
        
		startDate: moment().subtract('days', 60),
		endDate: moment()
                 
		},function(start, end) {
			$($(document.getElementById(this.element.context.id)).data('start-target')).val(start.format('YYYY-MM-DD 00:00'))
			$($(document.getElementById(this.element.context.id)).data('end-target')).val(end.format('YYYY-MM-DD 23:59'))
		}
	);

	$(".sidebar-collapse").find("li.childreen").click(function (){
		var menu = $(this);
		$("li.active").removeClass("active");
		menu.addClass("active");
		if(menu.parent().parent().hasClass("parent-menu")){
			menu.parent().parent().addClass("active");
		}
	});
	
	$(document).on('click', '[data-toggle="modal"]', function (e) {
		$('.modal-backdrop').appendTo("body");
	});
	
	$('.modal').appendTo("body");
	
	$('.crud-new-record').click(function(){
		var select = $(this).siblings().last().find('select')
		var id = select.attr('id')
		var name = select.attr('name')
		new_record(id,name)
		return false;
	})

};

function new_record(id,name){
	var model_name = name.split("[")[1].split("_id]")[0];
	
	$('#modal_new_record').attr("class","modal inmodal")
	$('#modal_new_record').addClass(model_name);

	var model_target = "#modal_new_record." + model_name;
	
	
	var url = "/crud/" + model_name + "/new.js?render=modal";
	var jqxhr = $.ajax(url)
	.done(function(result) {
		$(model_target).attr('data-source',id);
		$(model_target).attr('data-saved','false');
		$(model_target).on('hidden.bs.modal', function (e) {
			if($(model_target).attr('data-saved') == 'true'){
				var entity_desc = $(model_target).attr('data-entity-name')
				var entity_id   = $(model_target).attr('data-entity-id')
				$('#' + id).append($('<option>', {
				    value: entity_id,
						 text: entity_desc,
					selected: 'selected'
				}));
				$(model_target).attr('data-saved','false');
				$(model_target).attr('data-entity-name','')
				$(model_target).attr('data-entity-id','')
			}
		})
		$(model_target + ' .modal-body').html(result);
		$(model_target).modal('show');
		$('.modal-backdrop').appendTo("body");	
	});
}