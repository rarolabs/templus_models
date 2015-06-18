function atualiza_campos_crud(){
	$('.datepicker').datepicker({
		todayBtn: "linked",
		keyboardNavigation: false,
		forceParse: false,
		calendarWeeks: true,
		autoclose: true
	});
	
	$(".chosen").chosen();
	
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
	});
	
   $("[data-provider='summernote']").each(function(){
     $(this).summernote({ });
   });
	
	$('.modal').appendTo("body");
	
	$('.note-editor .note-dialog .modal').on('hidden.bs.modal', function () {
		$(".note-dialog").appendTo($(".note-editor"));
	});
	
	$('.crud-new-record').click(function(){
		var select = $(this).siblings().last().find('select')
		var id = select.attr('id')
		var name = select.attr('name')
		new_record(id,name)
		return false;
	});
	
	$(document).on('click', '[data-event$="Dialog"]', function (e) {
		$(".note-editor .note-dialog").appendTo("body");
		$('.modal-backdrop').appendTo("body");
	});
	
	$(document).on("click", ".add_nested_fields", function(){
		atualiza_campos_crud();
	});
	
	$(document).on('click', '[data-toggle="modal"]', function (e) {
		$('.modal-backdrop').appendTo("body");
	});
};

$(document).ready(function (){
	$("li.menu").on('click', function (){
		$("li.active").removeClass("active");
		var atual = $(this)
		$("ul.collapse.in").each(function(index, e){
			if(!atual.parents().is(e)){
				$(e).collapse('hide');
			}
		});
		$(this).addClass("active");
	});
	
	$("li.parent-menu").on('click', function (){
		$(this).addClass("active");
	});
});