// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery
//= require jquery_ujs
//= require autocomplete/jquery-ui-autocomplete
//= require autocomplete/autocomplete-rails
//= require jquery_nested_form
//= require wiselinks
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require peity/jquery.peity.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require inspinia.js
//= require toastr
//= require iCheck/icheck.min.js
//= require datapicker/bootstrap-datepicker.js
//= require datapicker/moment.js
//= require datapicker/daterangepicker.min.js
//= require dataTables/jquery.dataTables.js
//= require dataTables/dataTables.bootstrap.js
//= require dataTables/dataTables.responsive.js
//= require dataTables/dataTables.tableTools.min.js
//= require jasny/jasny-bootstrap.min.js
//= require fullcalendar/fullcalendar.min.js
//= require chosen/chosen.jquery.js
//= require summernote
//= require chartjs/Chart.min.js
//= require jsKnob/jquery.knob.js
//= require raro_crud.js
//= require templus_models.js
//= require mensagens.js
//= require permissoes.js
//= require initializer.js
//= require atualizacoes.js.coffee


$(document).ready(function (){
	atualiza_campos_crud();
	permission();
});