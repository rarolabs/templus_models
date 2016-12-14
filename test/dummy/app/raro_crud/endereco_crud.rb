class EnderecoCrud < RaroCrud

  titulo "Enderecos"
  subtitulo "Subtitulo", :index
  descricao "Descrição do Cadastro", :index

  link_superior nome: "Novo Endereco", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :created_at
  itens_por_pagina 20
  
  #Campos mostrados na index
  campo_tabela :cep,  label: "Cep"
  campo_tabela :logradouro,  label: "Logradouro"
  campo_tabela :complemento,  label: "Complemento"
  campo_tabela :numero,  label: "Numero"
  campo_tabela :bairro,  label: "Bairro"
  campo_tabela :cidade,  label: "Cidade"
  campo_tabela :usuario,  label: "Usuario"
    
  #Campos mostrados no formulários de cadastro
  campo_formulario :cep,  label: "Cep"
  campo_formulario :logradouro,  label: "Logradouro"
  campo_formulario :complemento,  label: "Complemento"
  campo_formulario :numero,  label: "Numero"
  campo_formulario :bairro,  label: "Bairro"
  campo_formulario :cidade, label: "Cidade", autocomplete: {classe: :cidade, campo: :nome, label_method: :cidade_estado}  
  campo_formulario :usuario,  label: "Usuario"
  

  #Campos mostrados na visualizacao
  campo_visualizacao :cep,  label: "Cep"
  campo_visualizacao :logradouro,  label: "Logradouro"
  campo_visualizacao :complemento,  label: "Complemento"
  campo_visualizacao :numero,  label: "Numero"
  campo_visualizacao :bairro,  label: "Bairro"
  campo_visualizacao :cidade,  label: "Cidade"
  campo_visualizacao :usuario,  label: "Usuario"
  

  #Campos mostrados na busca
  campo_busca :cep,  label: "Cep"
  campo_busca :logradouro,  label: "Logradouro"
  campo_busca :complemento,  label: "Complemento"
  campo_busca :numero,  label: "Numero"
  campo_busca :bairro,  label: "Bairro"
  campo_busca :cidade,  label: "Cidade"
  campo_busca :usuario,  label: "Usuario"
  

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