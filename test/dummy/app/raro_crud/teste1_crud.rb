class Teste1Crud < RaroCrud
  
  titulo "Teste1"
  link_superior "Novo Teste1", id: "novo-button", icon: "plus", link: "new"

  campo_tabela :teste,  label: "Nome", sort_field: :teste_nome
  
  grupo_formulario :teste, [
    {campo: :nome, label: "Nome"}
  ]
  campo_visualizacao :teste, label: "Nome"
  campo_busca :teste_id, label: "Nome"
  
end