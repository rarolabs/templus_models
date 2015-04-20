class TesteCrud < RaroCrud
  
  titulo "Teste"
  link_superior "Novo Teste", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome

  campo_tabela :nome,  label: "Nome"
  campo_formulario :nome, label: "Nome"
  script_formulario :console, "alert1.js"
  script_formulario :console2, "alert2.js"
  
  campo_visualizacao :nome, label: "Nome"
  campo_busca :nome, label: "Nome"
  
  escopos [[:raro, "Raro"], [:nao_raro, "Raro"]]
  
end