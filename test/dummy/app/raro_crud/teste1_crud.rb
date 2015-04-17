class Teste1Crud < RaroCrud
  
  titulo "Teste1"
  link_superior "Novo Teste1", id: "novo-button", icon: "plus", link: "new"

  campo_tabela :teste,  label: "Nome"
  
  grupo_formulario :teste, [
    {attribute: :nome, sf: {label: "Nome"}}
  ]
  campo_visualizacao :teste, label: "Nome"
  campo_busca :teste_id, label: "Nome"
  
end