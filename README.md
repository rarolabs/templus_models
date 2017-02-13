# Templus Models
##Gerando um CRUD
Utilize o generator CRUD para criar um novo crud
```ruby
rails g crud empresa
```
o arquivo empresa_crud.rb será criado:

```
create  app/raro_crud/empresa_crud.rb
```

O arquivo já configura o CRUD com todos os attributos do modelo:

```ruby
class EmpresaCrud < RaroCrud

  titulo "Empresas"
  subtitulo "Subtitulo", :index
  descricao "Descrição do Cadastro", :index

  link_superior "Novo Empresa", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :created_at
  itens_por_pagina 20

  #Campos mostrados na index
  campo_tabela :nome,  label: "Nome"
  campo_tabela :contato,  label: "Contato"
  campo_tabela :telefone,  label: "Telefone"
  campo_tabela :endereco,  label: "Endereco"
  
  
  #Campos mostrados no formulários de cadastro
  campo_formulario :nome,  label: "Nome"
  campo_formulario :contato,  label: "Contato"
  campo_formulario :telefone,  label: "Telefone"
  campo_formulario :endereco,  label: "Endereco"
  

  #Campos mostrados na visualizacao
  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :contato,  label: "Contato"
  campo_visualizacao :telefone,  label: "Telefone"
  campo_visualizacao :endereco,  label: "Endereco"
  

  #Campos mostrados na busca
  campo_busca :nome,  label: "Nome"
  campo_busca :contato,  label: "Contato"
  campo_busca :telefone,  label: "Telefone"
  campo_busca :endereco,  label: "Endereco"

end
```

##Alterar forma de visualização do campo

```rb
campo_visualizacao :tipo, label: "Tipo", label_method: :descricao_do_tipo
```

## Atributo especia de endereço
Para vincular um formulário de cadastro de endereço utilize o método *adicionar_endereco* no arquivo:

```ruby
class EmpresaCrud < RaroCrud

  titulo "Empresas"
  subtitulo "Subtitulo", :index
  descricao "Descrição do Cadastro", :index

  link_superior "Novo Empresa", id: "novo-button", icon: "plus", link: "new"
  
  adicionar_endereco
  ...
end
```

Depois adicione no seu modelo o metodo

```rb
accepts_nested_attributes_for :endereco, :allow_destroy => true
```

## Campos do tipo data
Para vincular o *datepicker* no campo do tipo Date

```rb
campo_formulario :data_nascimento, label: "Data de nascimento", as: :string, input_html: {class: "datepicker"}
```

Para formatar a data na tabela, utilize o *date_format*

```rb
campo_tabela :created_at,  label: "Data", date_format: "%d/%m/%Y"
```

Para ordernar a tabela por outro campo

```rb
campo_tabela :tipo_veiculo,  label: "Tipo de Veiculo", sort_field: :tipo_veiculo_descricao
```

## Campos do tipo boolean
Para vincular o *iCheck* no campo do tipo boolena

```rb
campo_formulario :data_nascimento, label: "Data de nascimento", input_html: {class: "i-checks"}
```

## Busca por intervalo
Para buscas de valores em um intervalo

```rb
campo_busca :salario, label: "Salário", as: :range
```

## Aplicando mascara
Para aplicar uma mascara em um campo

```rb
campo_formulario :data_nascimento, label: "Data de nascimento", input_html: {"data-mask" => "(99) 9999-9999"}
```

Para mascara de telefone com 8 e 9 digitos (com e sem DDD)
```rb
campo_formulario :data_nascimento, label: "Data de nascimento", input_html: {class: "mask-telefone"}
ou
campo_formulario :data_nascimento, label: "Data de nascimento", input_html: {class: "mask-telefone-ddd"}
```


## Aplicando Dica
Para aplicar uma dica em um campo

```rb
campo_formulario :cpf, label: "CPF", hint: "Somente números"
```

## Adicionando javascrit
Para adicionar um *javascript* em um formulário do RaroCrud, basta criar um arquivo *.js* dentro da seguinte pasta

```
assets/javascripts/crud/
```

Depois adicione em seu arquivo ModelCrud o javascript

```rb
script_formulario :cidade_estado
```

## Adicionando escopos
Para adicionar um *scope* a uma index do RaroCrud

```rb
escopos [[:maiores_que_1000, "Maiores"], [:menores_que_1000, "Menores"]]
```

Para adicionar um *partial* para o *scope* em uma index do RaroCrud

```rb
escopos "/cancelamentos/escopos"
```

## Adicionando ações
Para adicionar uma nova ação

```rb
acoes :pagar!, "Pagar"
````

Caso deseja inserir uma condição, basta adicionar um *proc* ao comando

```rb
acoes :pagar!, "Pagar", Proc.new {|p| Usuario.current.ability.can?(:create, p)}
````

Caso necessite de um ação que redireciona para uma view, basta adicionar uma *partial*

```rb
class PapelCrud < RaroCrud
acoes :associar, "Definir permissões", Proc.new {|p| Usuario.current.ability.can?(:create,p)}
end
```
Local e conteudo da *partial*

```
papeis/_associar.html.erb

<%= render_crud do %>
#Conteudo HTML
<% end %>
```
OBS: Caso você não necessite do template do RaroCrud, adicione somente o Conteudo HTML

## Adicionando links para cada registro

```rb
links "Permissão", url: "/crud/papel"
```

Link com wiselink
```rb
links "Permissão Wiselink", url: "/crud/papel", wiselink: true
```

Link para associações
```rb
links "Testes1", associacao: :teste1
```

Link com partial
```rb
links "acoes", partial: "/atendimentos/acoes"
```

## Retirando a opção de adicionar novo registro em relações *belongs_to*

```rb
campo_formulario :papel, label: "Papel", label_method: :descricao, add_registro: false
```

## Adicionar condição para mostrar um campo no formulário

```rb
  campo_formulario :perfil, label: "Perfil", label_method: :descricao, if: Proc.new {|obj| Usuario.current.root? }
```

## Manipulando *actions* padrão do RaroCrud

Para remover um *action* da tabela do RaroCrud

```rb
sem_visualizacao
sem_edicao
sem_exclusao
````

Para remover um *action* de acordo com uma condição

```rb
edicao Proc.new {|obj| !obj.root? }
exclusao Proc.new {|obj| !obj.root? }
visualizacao Proc.new {|obj| obj.root? }
```

## Manipulando links superiores

Adicionando um link
```rb
link_superior "Novo Teste", id: "novo-button", icon: "plus", link: "new"
```
Esse link será */crud/teste/new*

Adicionando uma url
```rb
link_superior "Inicio", id: "novo-button", icon: "", url: :busca_api_cidades
ou
link_superior "Inicio", id: "novo-button", icon: "", url: "/api/busca/cidades"
```
Nesse caso será um redirecionamento

Adicionando uma partial
```rb
link_superior "Novo", partial: "/usuarios/actions"
```

Aplicando permissão ao link
```rb
link_superior "Novo Teste", id: "novo-button", icon: "plus", link: "new", can: Proc.new {|obj| Usuario.current.ability.can?(:create, Teste)}
```

## Adicionando aucomplete
Para adicionar *autocomplete* em um campo de formulário

campo_formulario :cidade, label: "Cidade", autocomplete: {classe: :cidade, campo: :nome, label_method: :cidade_estado}


## Formulário Alinhado
Para adicionar formulários alinhados utilize o método _grupo_formulario_:

```rb
  campo_formulario :dado_boleto, label: "Dados para emissão de boleto", 
                   grupo: [{campo: :banco, label: "Banco", add_registro: false},
                           {campo: :conta, label: "Conta"},
                           {campo: :observacao, label: "Instruções bancárias"}]
```

Não se esqueça de permitir os campos dos filhos no modelo do pai com _accepts_nested_attributes_for_

```rb
  accepts_nested_attributes_for :subtopicos, :allow_destroy => true
```

Caso deseja um label diferente para os botões Adicionar e Remover do grupo, basta adicionar o campo *sublabel*

```rb
  campo_formulario :dado_boleto, label: "Dados para emissão de boleto", sublabel: "Boleto" 
                   grupo: [{campo: :banco, label: "Banco", add_registro: false},
                           {campo: :conta, label: "Conta"},
                           {campo: :observacao, label: "Instruções bancárias"}]
```






