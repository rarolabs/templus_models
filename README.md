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

## Aplicando mascara
Para aplicar uma mascara em um campo

```rb
campo_formulario :data_nascimento, label: "Data de nascimento", input_html: {"data-mask" => "(99) 9999-9999"}
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





