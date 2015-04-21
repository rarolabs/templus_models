class <%=@model.name%>Crud < RaroCrud

  titulo "<%=@model.name.pluralize%>"
  subtitulo "Subtitulo", :index
  descricao "Descrição do Cadastro", :index

  link_superior "Novo <%=@model.name%>", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :created_at
  itens_por_pagina 20
  
  #Exemplo de acao customizada
  #acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}
  
  <%
    @atributos = @model.attribute_names
    @atributos.delete("id")
  %>
  #Campos mostrados na index
  <%@atributos.each do |atributo| %>campo_tabela :<%=atributo.to_sym%>,  label: "<%=atributo.humanize%>"<%="\n"%>  <%end%>
  
  #Campos mostrados no formulários de cadastro
  <%@atributos.each do |atributo| %>campo_formulario :<%=atributo.to_sym%>,  label: "<%=atributo.humanize%>"<%="\n"%>  <%end%>

  #Campos mostrados na visualizacao
  <%@atributos.each do |atributo| %>campo_visualizacao :<%=atributo.to_sym%>,  label: "<%=atributo.humanize%>"<%="\n"%>  <%end%>

  #Campos mostrados na busca
  <%@atributos.each do |atributo| %>campo_busca :<%=atributo.to_sym%>,  label: "<%=atributo.humanize%>"<%="\n"%>  <%end%>

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