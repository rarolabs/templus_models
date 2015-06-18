class PapelCrud < RaroCrud
  
  titulo "Papéis"
  link_superior "Novo Papel", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome

  acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}

  campo_tabela :nome,  label: "Nome"
  campo_tabela :descricao,  label: "Descrição"

  campo_formulario :nome, label: "Nome"
  campo_formulario :descricao, label: "Descrição"
  campo_formulario :chave, label: "Chave"

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :descricao,  label: "Descrição"

  campo_busca :nome,  label: "Nome"
  campo_busca :descricao,  label: "Descrição"
end