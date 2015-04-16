class <%=nome%>Crud < RaroCrud
  titulo "<%nome.pluralize%>"
  subtitulo "Subtitulo", :index

  descricao "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", :index

  link_superior "Novo <%=nome%>", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :created_at
  itens_por_pagina 5

  #Exemplo de acao customizada
  #acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}

  #Campos mostrados na index
  <%campos.each do |campo| %>
  campo_tabela <%=campo.to_sym%>,  label: "<%=campo.humanize%>"
  <%end

  #Campos mostrados no formulários de cadastro
  <%campos.each do |campo| %>
  campo_formulario <%=campo.to_sym%>,  label: "<%=campo.humanize%>"
  <%end
  
  #Campos mostrados na visualizacao
  <%campos.each do |campo| %>
  campo_visualizacao <%=campo.to_sym%>,  label: "<%=campo.humanize%>"
  <%end
  
  #Campos mostrados na busca
  <%campos.each do |campo| %>
  campo_busca <%=campo.to_sym%>,  label: "<%=campo.humanize%>"
  <%end
  
  #Exemplos de customizacao
  # Datepicker
  # campo_formulario :data,  label: "Data", as: :string, input_html: {class: "datepicker"}
  # Checkbox
  # campo_formulario :check,  label: "Check", input_html: {class: "i-checks"}
  # upload
  # campo_formulario :arquivo,  label: "Foto", input_html: {class: "ace-input-file"}
  # Relacionamento
  # campo_formulario :grupos, label: "Grupos",
  #                          label_method: :nome,
  #                          as: :check_boxes, 
  #                          input_html: {class: "i-checks"}
  # campo_busca :nome, model: 'Grupo', full_name: 'grupos_nome', label: "Nome"
  # escopos
  # escopos [[:maiores_que_1000, "Maiores"], [:menores_que_1000, "Menores"], [:ativos, "Ativos"], [:nao_ativos, "Desativos"]]
end