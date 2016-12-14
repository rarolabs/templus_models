class Teste1Crud < RaroCrud
  
  titulo "Teste1"
  link_superior nome: "Novo Teste1", id: "novo-button", icon: "plus", link: "new"

  acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}

  campo_tabela :descricao, label: "Descrição"
  campo_tabela :teste,  label: "Nome", sort_field: :teste_nome
  
  campo_formulario :descricao, label: "Descrição"
  grupo_formulario :teste, [
    {campo: :nome, label: "Nome"}
  ]
  
  campo_visualizacao :descricao, label: "Descrição"
  campo_visualizacao :teste, label: "Teste"
  
  campo_busca :descricao, label: "Descrição"
  campo_busca :nome, label: "Teste", model: "Teste", full_name: "teste_nome", dont_assoc: true
end