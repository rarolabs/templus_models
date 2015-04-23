class TesteCrud < RaroCrud

  titulo "Testes"
  subtitulo "Subtitulo", :index
  descricao "Descrição do Cadastro", :index

  link_superior "Novo Teste", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :created_at
  itens_por_pagina 20
  
  #Exemplo de acao customizada
  #acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}
  
  
  #Campos mostrados na index
  campo_tabela :nome,  label: "Nome"
  campo_tabela :created_at,  label: "Created at"
  campo_tabela :updated_at,  label: "Updated at"
  
  
  #Campos mostrados no formulários de cadastro
  campo_formulario :nome,  label: "Nome", if: Proc.new{|o| o.try(:nome) == "Leonardo Raro" || o.new_record?}, value: Proc.new{|o| o.object.try(:teste1).try(:descricao)}
  grupo_formulario :teste1, [
    {campo: :descricao, label: "Descrição"}
  ]
  

  #Campos mostrados na visualizacao
  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :created_at,  label: "Created at"
  campo_visualizacao :updated_at,  label: "Updated at"
  

  #Campos mostrados na busca
  campo_busca :nome,  label: "Nome"
  campo_busca :created_at,  label: "Created at"
  campo_busca :updated_at,  label: "Updated at"
  

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