window.executa_atualizacoes = ->
  atualiza_campos_crud()
  permission()

$ ->
  wiselinks = new Wiselinks($('#page-wrapper-main'));
  # $('#list').jstree
  #   "plugins": ["html_data"]
  #   "core" : { "initially_open" : [ "root" ] }

  # $(document).off('page:loading').on(
  #     'page:loading'
  #     (event, $target, render, url) ->
  #         NProgress.start()
  #         bloqueia()
  # )
  #
  # $(document).off('page:redirected').on(
  #     'page:redirected'
  #     (event, $target, render, url) ->
  #       NProgress.start()
  #       bloqueia()
  # )
  #
  # $(document).off('page:always').on(
  #     'page:always'
  #     (event, xhr, settings) ->
  #       NProgress.done()
  # )
  #
  $(document).off('page:done').on(
      'page:done'
      (event, $target, status, url, data) ->
          # NProgress.remove()
          # $('.datepicker').datepicker({format: 'dd/mm/yyyy'})
          # $('.timepicker').timepicker()
          # $('.best_in_place').best_in_place()
          window.executa_atualizacoes()
          # desbloqueia()
          # if $target.attr('id') is 'main-container'
          #   $('select#filter').change ->
          #     $('#scope-select').submit()
  )
  # $(document).off('page:fail').on(
  #     'page:fail'
  #     (event, $target, status, url, error, code) ->
  #       desbloqueia()
  #       console.debug("***************ERRO*************")
  #       console.debug('URL:')
  #       console.debug(url)
  #       console.debug('Target:')
  #       console.debug($target)
  #       console.debug('Status:')
  #       console.debug(status)
  #       console.debug('Error:')
  #       console.debug(error)
  #       console.debug('Code:')
  #       console.debug(code)
  #       console.debug("***************ERRO*************")
  #       $.gritter.add({title: 'Erro', text: 'Não foi possível completar sua requisição. Entre em contato com o suporte', class_name: 'gritter-error'});
  # )
