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
  link_superior nome: "new", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :created_at
  itens_por_pagina 20

  #Campos mostrados na index
  campo_tabela :nome
  campo_tabela :contato
  campo_tabela :telefone
  campo_tabela :endereco

  #Campos mostrados no formulários de cadastro
  campo_formulario :nome
  campo_formulario :contato
  campo_formulario :telefone
  campo_formulario :endereco

  #Campos mostrados na visualizacao
  campo_visualizacao :nome
  campo_visualizacao :contato
  campo_visualizacao :telefone
  campo_visualizacao :endereco

  #Campos mostrados na busca
  campo_busca :nome
  campo_busca :contato
  campo_busca :telefone
  campo_busca :endereco

  #Condição para relatórios
  listagem proc { |obj| !obj.root? }
  listagem_pdf proc { |obj| !obj.root? }
  listagem_excel proc { |obj| !obj.root? }

  #Campos mostrados no relatório
  campo_listagem :nome
  campo_listagem :contato
  campo_listagem :telefone
  campo_listagem :endereco

  #Condição para impressão
  impressao proc { |obj| !obj.root? }

  #Campos mostrados na impressão
  campo_impressao :nome
  campo_impressao :contato
  campo_impressao :telefone
  campo_impressao :endereco

end
```
##Customizar label
Por padrão o RaroCrud irá buscar a tradução com a chave
```rb
 simple_form.labels.modelo.atributo
 Ex: simple_form.labels.usuario.nome
```
Caso deseja customizar pode ser adicionar um label
```rb
 campo_formulario :nome, label: "shared.nome"
```

OBS: Isso serve para *campo_tabela*, *campo_formulario*, *campo_visualizacao*, *campo_busca*, *campo_listagem* e *campo_impressão*

##Alterar forma de visualização do campo

```rb
campo_visualizacao :tipo, label_method: :descricao_do_tipo
```

## Atributo especial de endereço
Para vincular um formulário de cadastro de endereço utilize o método *adicionar_endereco* no arquivo:

```ruby
class EmpresaCrud < RaroCrud

  adicionar_endereco
  ...
end
```

Depois adicione no seu modelo o método

```rb
accepts_nested_attributes_for :endereco, :allow_destroy => true
```

## Campos do tipo data
Para vincular o *datepicker* no campo do tipo Date

```rb
campo_formulario :data_nascimento, as: :string, input_html: {class: "datepicker"}
```

Para formatar a data na tabela, utilize o *date_format*, com a chave de tradução.

```rb
campo_tabela :created_at, date_format: "shared.data.default"
```

Para ordernar a tabela por outro campo

```rb
campo_tabela :tipo_veiculo, sort_field: :tipo_veiculo_descricao
```

## Campos do tipo boolean
Para vincular o *iCheck* no campo do tipo boolena

```rb
campo_formulario :data_nascimento, input_html: {class: "i-checks"}
```

## Aplicando máscara
Para aplicar uma máscara em um campo

```rb
campo_formulario :data_nascimento, input_html: {"data-mask" => "(99) 9999-9999"}
```

Para mascara de telefone com 8 e 9 digitos (com e sem DDD)
```rb
campo_formulario :data_nascimento, input_html: {class: "mask-telefone"}
ou
campo_formulario :data_nascimento, input_html: {class: "mask-telefone-ddd"}
```


## Aplicando Dica
Para aplicar uma dica em um campo

```rb
campo_formulario :cpf, hint: "Somente números"
```

## Adicionando javascript
Para adicionar um *javascript* em um formulário do RaroCrud, basta criar um arquivo *.js* dentro da seguinte pasta

```
assets/javascripts/crud/
```

Depois adicione em seu arquivo ModelCrud o javascript

```rb
script_formulario :cidade_estado
```

## Adicionando escopos
Para adicionar um *scope* a uma index do RaroCrud. Deve passar a chave de tradução.

```rb
escopos [
  [:nao_iniciado, "rarocrud.candidato.states.nao_iniciado"],
  [:iniciado, "rarocrud.candidato.states.iniciado"],
  [:respondido, "rarocrud.candidato.states.respondido"],
  [:bloqueado, "rarocrud.candidato.states.bloqueado"],
  [:expirado, "rarocrud.candidato.states.expirado"],
  [:com_colaboradores, "rarocrud.candidato.scopes.com_colaboradores"],
  [:all, "rarocrud.candidato.states.todos"]
]
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
acoes :pagar!, "Pagar", proc {|p| Usuario.current.ability.can?(:create, p)}
````

Caso necessite de um ação que redireciona para uma view, basta adicionar uma *partial*

```rb
class PapelCrud < RaroCrud
acoes :associar, "Definir permissões", proc {|p| Usuario.current.ability.can?(:create,p)}
end
```
Local e conteudo da *partial*

```
papeis/_associar.html.erb

<%= render_crud do %>
#Conteúdo HTML
<% end %>
```
OBS: Caso você não necessite do template do RaroCrud, adicione somente o Conteúdo HTML

Se desejar que a requisição da ação seja *wiselinks*
```rb
class PapelCrud < RaroCrud
acoes :associar, "Definir permissões", proc {|p| Usuario.current.ability.can?(:create,p)}, wiselink: true
end
```

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
campo_formulario :papel, label_method: :descricao, add_registro: false
```

## Adicionar condição para mostrar um campo no formulário

```rb
  campo_formulario :perfil, if: proc {|obj| Usuario.current.root? }
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
edicao proc {|obj| !obj.root? }
exclusao proc {|obj| !obj.root? }
visualizacao proc {|obj| obj.root? }
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
link_superior nome: "new", id: "novo-button", icon: "plus", link: "new", can: proc {|obj| Usuario.current.ability.can?(:create, Teste)}
```

## Adicionando aucomplete
Para adicionar *autocomplete* em um campo de formulário

campo_formulario :cidade, autocomplete: {classe: :cidade, campo: :nome, label_method: :cidade_estado}


## Formulário Alinhado
Para adicionar formulários alinhados utilize o método _grupo_formulario_:

```rb
  campo_formulario :dado_boleto,
                   grupo: [{ campo: :banco, add_registro: false },
                           { campo: :conta },
                           { campo: :observacao }]
```

Não se esqueça de permitir os campos dos filhos no modelo do pai com _accepts_nested_attributes_for_

```rb
  accepts_nested_attributes_for :subtopicos, :allow_destroy => true
```

Caso deseja um label diferente para os botões Adicionar e Remover do grupo, basta adicionar o atributo *sublabel* com a chave da tradução

```rb
  campo_formulario :dado_boleto, sublabel: "shared.boleto"
                   grupo: [{ campo: :banco, add_registro: false },
                           { campo: :conta },
                           { campo: :observacao }]
```

# Configuração

Para configurar o RaroCrud crie um initializer com o seguinte código:

```
TemplusModels.configure do |config|

  # Se for true, os links de visualizar, editar, e excluir na index
  # serão mostrados com ícones, ao invés de texto.
  # default: false
  config.usar_icones = true

  # Se for false, as rotas do rarocrud não serão adicionadas
  # default: true
  config.adicionar_rotas = false
end
```

## Agrupar campos do formulário
Para agrupar campos de um formulário utilize o método _agrupar_campos_:

```rb
  agrupar_campos :documento do
    campo_formulario :cpf_cnpj, label: I18n.t('simple_form.shared.nome')
    campo_formulario :rg
  end
```

## Separar campos do formulário
Caso deseja inserir um *HR* entre campos do formulário utilize o método _separar_formulario_.


## Impressão de PDF

É possível gerar um PDF com os dados de um registro. Para gerar o PDF utilize o método `relatorio_impressao`:

```
relatorio_impressao :nome
relatorio_impressao :email
```
O link para gerar o PDF fica na view `show`, ao lado dos links de editar e excluir o registro.

Para atributos que são imagens (CarrierWave), o RaroCrud irá colocar um link para a imagem. É possível renderizar a
imagem passando a opção `render: true`. OBS: para a imagem ser renderizada, é necessário que ela tenha uma versão `thumb`.

```
relatorio_impressao :logo, render: true
```

### Adicionar imagem no cabeçalho

Para adicionar uma imagem no cabeçalho do relatório em PDF deve ser utilizado o método `relatorio_impressao_logo`, que possui 3 assinaturas:

* quando chamado sem nenhum argumento, irá renderizar a imagem `Templus.logo`.
* quando chamado com uma string, a imagem será renderizada através do helper `image_tag`, e vai buscar a imagem no asset pipeline.
* quando chamado com um símbolo, esse símbolo será interpretado como um atributo do model que representa uma imagem (CarrierWave).

Exemplos:

```
relatorio_impressao_logo
relatorio_impressao_logo :logotipo
relatorio_impressao_logo 'imagem.png'
```

### Adicionar título ao cabeçalho

Para adicionar um título no cabeçalho do relatório em PDF deve ser utilizado o método `relatorio_impressao_titulo`, que possui 3 assinaturas:

* quando chamado sem nenhum argumento, irá utilizar o valor `Templus.nome_aplicacao`.
* quando chamado com uma string, essa string será utilizada com título.
* quando chamado com um símbolo, esse símbolo será interpretado como um atributo ou método do model, e o valor retornado pelo atributo ou método será utilizado no título.

Exemplos:

```
relatorio_impressao_titulo
relatorio_impressao_titulo :descricao
relatorio_impressao_titulo 'Título do PDF'
```

## Listagem em Excel

É possível gerar um arquivo excel a partir da `index` de um rarocrud. Utilize o método `relatorio_listagem` para isso:

```
relatorio_listagem :nome
relatorio_listagem :email
```
O link para gerar o Excel fica na view `index`.
