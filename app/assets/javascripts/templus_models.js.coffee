window.search_predicate = (select) -> 
  target = $($(select).data('target'))
  er = /\_(eq|not\_eq|cont|not\_cont|start|end|lt|lteq|gt|gteq)/
  new_name = target.attr("name").replace(er,"_" + $(select).val())
  target.attr("name",new_name)