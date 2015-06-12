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

## Atributo especia de endereço
Para vincular um formlário de cadastro de endereço utilize o método *adicionar_endereco* no arquivo:

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

## Campos do tipo data
Para vincular o *datepicker* no campo do tipo Date

```rb
campo_formulario :data_nascimento, label: "Data de nascimento", as: :string, input_html: {class: "datepicker"}
```

Para formatar a data na tabela, utilize o *date_format*

```rb
campo_tabela :created_at,  label: "Data", date_format: "%d/%m/%Y"
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
