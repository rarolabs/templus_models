class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior "Novo Usuário", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome

  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"

  campo_formulario :nome, label: "Nome"
  campo_formulario :email, label: "Email", default_test_pos: "@rarolabs.com"
  adicionar_endereco

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :email, label: "email"
  campo_visualizacao :endereco, label: "Endereço"

  campo_busca :nome,  label: "Nome"
  campo_busca :email, label: "email"
end
