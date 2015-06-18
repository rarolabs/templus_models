class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior "Novo Usuário", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome

  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"


  campo_formulario :nome, label: "Nome"
  campo_formulario :email, label: "Email", default_test_pos: "@rarolabs.com"
  campo_formulario :password, label: "Senha", default_test: "12345678", edit: false
  campo_formulario :password_confirmation, label: "Confirmação Senha", default_test: "12345678", edit: false
  campo_formulario :papel, label: "Papel",
                           label_method: :descricao

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :email, label: "email"
  campo_visualizacao :papel, label: "Papel"

  campo_busca :nome,  label: "Nome"
  campo_busca :email, label: "email"
  campo_busca :papel_id,  label: "Papel"

end
