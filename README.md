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

  link_superior nome: "new", id: "novo-button", icon: "plus", link: "new", can: proc {|obj| Usuario.current.ability.can?(:create, Teste)}

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
  campo_busca :nome,  label:
  campo_busca :contato
  campo_busca :telefone
  campo_busca :endereco

  #Condição para relatórios
  listagem proc {|obj| !obj.root? }
  listagem_pdf proc {|obj| !obj.root? }
  listagem_excel proc {|obj| !obj.root? }

  #Campos mostrados no relatório
  campo_listagem :nome
  campo_listagem :contato
  campo_listagem :telefone
  campo_listagem :endereco

  #Condição para impressão
  impressao proc {|obj| !obj.root? }

  #Campos mostrados na impressão
  campo_impressao :nome
  campo_impressao :contato
  campo_impressao :telefone
  campo_impressao :endereco

end
```

##Customizar label
Por padrão o RaroCrud irá buscar a tradução com a chave
```
simple_form.labels.modelo.atributo
Ex: simple_form.labels.usuario.nome
```
Caso deseja customizar pode ser adicionar um label
```ruby
campo_formulario :nome, label: "shared.nome"
```

OBS: Isso serve para *campo_tabela*, *campo_formulario*, *campo_visualizacao*, *campo_busca*, *campo_listagem* e *campo_impressão*


##Alterar forma de visualização do campo

```ruby
campo_visualizacao :tipo, label_method: :descricao_do_tipo
```

## Atributo especial de endereço
Para vincular um formulário de cadastro de endereço utilize o método *adicionar_endereco* no arquivo:

```ruby
class EmpresaCrud < RaroCrud

  #...
  campo_formulario ....
  adicionar_endereco
  #...
end
```

Depois adicione no seu modelo o método

```ruby
accepts_nested_attributes_for :endereco, :allow_destroy => true
```

## Campos do tipo data
Para vincular o *datepicker* no campo do tipo Date

```ruby
campo_formulario :data_nascimento, as: :string, input_html: {class: "datepicker"}
```

Para formatar a data na tabela, utilize o *date_format*, com a chave de tradução.

```ruby
campo_tabela :created_at, date_format: "shared.data.default"
```

Para ordernar a tabela por outro campo

```ruby
campo_tabela :tipo_veiculo, sort_field: :tipo_veiculo_descricao
```

## Campos do tipo boolean
Para vincular o *iCheck* no campo do tipo boolena

```ruby
campo_formulario :data_nascimento, input_html: {class: "i-checks"}
```

## Campos do tipo check_boxes
Os campos checkbox podem ser campo_formulario e/ou campo_busca

```ruby
campo_formulario :sexo,
                 label: 'simple_form.labels.perfil.perfis_perfil',
                 as: :check_boxes,
                 input_html: {class: "i-checks"},
                 collection_if: Proc.new { User.sexos.map{|s| [s, s]} }
```

```ruby
campo_busca :sexo,
            as: :check_boxes,
            input_html: {class: "i-checks"}
            collection: Proc.new { User.sexos.map{|s| [s, s]} }
```

* Obs: No campo Label deve ser passado o path para a tradução ou não informar o label. Assim ele irá automaticamente buscar de um path predefinido.


## Campos do tipo select
Para os campos select no campo_busca, é possível incluir a opção *include_blank*. 
Caso essa opção não seja definida, por padrão o *include_blank* terá valor *true*. 
Caso contrário, serão aceitos os valores *true* ou *false* para, respectivamente, a inclusão ou não dessa propriedade.

Para os dois exemplos abaixo, será incluída essa propriedade.
```ruby
campo_formulario :sexo,
                 label: 'simple_form.labels.perfil.perfis_perfil',
                 as: :select,
                 input_html: {class: "i-checks"},
                 collection_if: Proc.new { User.sexos.map{|s| [s, s]} }
```

```ruby
campo_formulario :sexo,
                 label: 'simple_form.labels.perfil.perfis_perfil',
                 as: :select,
                 input_html: {class: "i-checks"},
                 collection_if: Proc.new { User.sexos.map{|s| [s, s]} },
                 include_blank: true
```

Para o exemplo abaixo, não será incluída essa propriedade.
```ruby
campo_formulario :sexo,
                 label: 'simple_form.labels.perfil.perfis_perfil',
                 as: :select,
                 input_html: {class: "i-checks"},
                 collection_if: Proc.new { User.sexos.map{|s| [s, s]} },
                 include_blank: false
```

## Busca por intervalo
Para buscas de valores em um intervalo

```ruby
campo_busca :salario, label: "simple_form.labels.perfil.perfis_perfil", as: :range
```

## Aplicando máscara
Para aplicar uma máscara em um campo

```ruby
campo_formulario :data_nascimento, input_html: {"data-mask" => "(99) 9999-9999"}
```

Para mascara de telefone com 8 e 9 digitos (com e sem DDD)
```ruby
campo_formulario :data_nascimento, input_html: {class: "mask-telefone"}
#ou
campo_formulario :data_nascimento, input_html: {class: "mask-telefone-ddd"}
```


## Aplicando Dica
Para aplicar uma dica em um campo

```ruby
campo_formulario :cpf, hint: "Somente números"
```

## Adicionando javascript
Para adicionar um *javascript* em um formulário do RaroCrud, basta criar um arquivo *.js* dentro da seguinte pasta

```
assets/javascripts/crud/
```

Depois adicione em seu arquivo ModelCrud o javascript

```ruby
script_formulario :cidade_estado
```

## Adicionando escopos
Para adicionar um *scope* a uma index do RaroCrud, deve ser passada uma chave de tradução.

```ruby
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

```ruby
escopos "/cancelamentos/escopos"
```

## Adicionando ações
Para adicionar uma nova ação

```ruby
acoes :pagar!, "Pagar"
```

Caso deseja inserir uma condição, basta adicionar um *proc* ao comando

```ruby
acoes :pagar!, "Pagar", proc {|p| Usuario.current.ability.can?(:create, p)}
```

Caso necessite de um ação que redireciona para uma view, basta adicionar uma *partial*

```ruby
class PapelCrud < RaroCrud
acoes :associar, "Definir permissões", proc {|p| Usuario.current.ability.can?(:create,p)}
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

```ruby
links "Permissão", url: "/crud/papel"
```

Link com wiselink
```ruby
links "Permissão Wiselink", url: "/crud/papel", wiselink: true
```

Link para associações
```ruby
links "Testes1", associacao: :teste1
```

Link com partial
```ruby
links "acoes", partial: "/atendimentos/acoes"
```

## Retirando a opção de adicionar novo registro em relações *belongs_to*

```ruby
campo_formulario :papel, label_method: :descricao, add_registro: false
```

## Adicionar condição para mostrar um campo no formulário

```ruby
  campo_formulario :perfil, if: proc {|obj| Usuario.current.root? }
```

## Manipulando *actions* padrão do RaroCrud

Para remover um *action* da tabela do RaroCrud

```ruby
sem_visualizacao
sem_edicao
sem_exclusao
```

Para remover um *action* de acordo com uma condição

```ruby
edicao proc {|obj| !obj.root? }
exclusao proc {|obj| !obj.root? }
visualizacao proc {|obj| obj.root? }
```

## Manipulando links superiores

Adicionando um link
```ruby
link_superior "Novo Teste", id: "novo-button", icon: "plus", link: "new"
```
Esse link será */crud/teste/new*

Adicionando uma url
```ruby
link_superior "Inicio", id: "novo-button", icon: "", url: :busca_api_cidades
#ou
link_superior "Inicio", id: "novo-button", icon: "", url: "/api/busca/cidades"
```
Nesse caso será um redirecionamento

Adicionando uma partial
```ruby
link_superior "Novo", partial: "/usuarios/actions"
```

Aplicando permissão ao link
```ruby
link_superior nome: "new", id: "novo-button", icon: "plus", link: "new", can: proc {|obj| Usuario.current.ability.can?(:create, Teste)}
```

## Adicionando autocomplete
Para adicionar *autocomplete* em um campo de formulário

campo_formulario :cidade, autocomplete: {classe: :cidade, campo: :nome, label_method: :cidade_estado}


## Formulário Alinhado
Para adicionar formulários alinhados utilize o método _grupo_formulario_:

```ruby
  campo_formulario :dado_boleto, label: "shared.boleto",
                   grupo: [{campo: :banco, add_registro: false},
                           {campo: :conta},
                           {campo: :observacao}]
```

Não se esqueça de permitir os campos dos filhos no modelo do pai com _accepts_nested_attributes_for_

```ruby
  accepts_nested_attributes_for :subtopicos, :allow_destroy => true
```

Caso deseja um label diferente para os botões Adicionar e Remover do grupo, basta adicionar o atributo *sublabel* com a chave da tradução

```ruby
  campo_formulario :dado_boleto, label: "shared.boleto", sublabel: "shared.sub_boleto",
                   grupo: [{campo: :banco, add_registro: false},
                           {campo: :conta},
                           {campo: :observacao}]
```

# Configuração

Para configurar o RaroCrud crie um initializer com o seguinte código:

```ruby
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




## Impressão de PDF

É possível gerar um PDF com os dados de um registro. Para gerar o PDF utilize o método `relatorio_impressao`:

```ruby
relatorio_impressao :nome
relatorio_impressao :email
```
O link para gerar o PDF fica na view `show`, ao lado dos links de editar e excluir o registro.

Para atributos que são imagens (CarrierWave), o RaroCrud irá colocar um link para a imagem. É possível renderizar a
imagem passando a opção `render: true`. OBS: para a imagem ser renderizada, é necessário que ela tenha uma versão `thumb`.

```ruby
relatorio_impressao :logo, render: true
relatorio_impressao :nome, width: "25px", height: "100px"
```
Duas outras opções podem ser definidas: `width` e `height`. Estes atribuitos são opcionais e alteram, respectivamente, a largura e altura de uma célula da tabela.

## Listagem em Excel e PDF

É possível gerar uma listagem dos registros de um CRUD em Excel ou PDF. Utilize o método `relatorio_listagem` para isso:

```
relatorio_listagem :nome, only :excel, width: "25px", height: "100px"
relatorio_listagem :email, only: :pdf
relatorio_listagem :telefone, height: "100px"
relatorio_listagem :logotipo, render: true
```
É possível limitar quais campos são mostrados no excel ou no pdf, basta passar a chave `:only` com `:excel` ou `:pdf`, para indicar que o campo só deve ser mostrado no excel ou no PDF, respectivamente.
Duas outras opções podem ser definidas: `width` e `height`. Estes atribuitos são opcionais e alteram, respectivamente, a largura e altura de uma célula da tabela.

Os links para gerar as listagens ficam na view `index`.



### Configuração do PDF

É possível configurar o PDF gerado utilizando os métodos `setup_relatorio_listagem` e `setup_relatorio_impressao`:

Segue abaixo possíveis opções (todas são opcionais)

```ruby
setup_relatorio_listagem orientation: 'Portrait', top: 40, bottom: 20, header: 'report/header.pdf.erb', footer: 'report/footer.pdf.erb'
setup_relatorio_impressao orientation: 'Landscape', top: 30, bottom: 10, header: 'report/header.pdf.erb', footer: 'report/footer.pdf.erb'
```

As opções abaixo têm os seguintes valores por `default`:

```ruby
orientation: 'Portrait'
top: 20
bottom: 20
```
As opções acima são baseadas na gem [wicked_pdf](https://github.com/mileszs/wicked_pdf)