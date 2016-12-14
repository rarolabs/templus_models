class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior nome: "Novo Usuário", id: "novo-button", icon: "plus", link: "new"
  link_superior nome: "Inicio", id: "novo-button", icon: "", url: :busca_api_cidades
  link_superior nome: "Novo", partial: "/usuarios/actions"

  ordenar_por :nome
  edicao Proc.new {|obj| !obj.root? }
  exclusao Proc.new {|obj| !obj.root? }
  visualizacao Proc.new {|obj| !obj.root? }

  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"

  campo_formulario :nome, label: "Nome"
  campo_formulario :email, label: "Email", default_test_pos: "@rarolabs.com"
  campo_formulario :password, label: "Senha", default_test: "12345678", edit: false
  campo_formulario :password_confirmation, label: "Confirmação Senha", default_test: "12345678", edit: false
  campo_formulario :perfil, label: "Perfil", label_method: :descricao, input_html: {class: "chosen" ,   "data-placeholder" => "Escolha o perfil..."}, if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :novo_papel, label: "Novo Papel", label_method: :descricao, input_html: {class: "chosen" ,   "data-placeholder" => "Escolha o papel..."}, if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :contatos, label: "Contatos", grupo: [{campo: :nome, label: "Nome"},
                                                         {campo: :email, label: "Email"},
                                                         {campo: :telefones, label: "Telefones do contato", grupo: [{campo: :numero, label: "Número"}]}]

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :email, label: "email"
  campo_visualizacao :perfil, label: "Papel", visible_if: Proc.new {Usuario.current.root? }

  campo_busca :nome,  label: "Nome"
  campo_busca :email, label: "email"
  campo_busca :papel_id,  label: "Papel", visible_if: Proc.new {Usuario.current.root? }

end
