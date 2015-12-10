class RaroCrud
  @@order_field               = {}
  @@per_page                  = {}
  @@index_fields              = {}
  @@form_fields               = {}
  @@form_group                = {}
  @@form_scripts              = {}
  @@view_fields               = {}
  @@search_fields             = {}
  @@test_fields               = {}
  @@top_links                 = {} 
  @@title                     = {}
  @@subtitle_index            = {}
  @@description_index         = {}
  @@actions                   = {}
  @@links                     = {}
  @@edit_action               = {}
  @@condition_edit_action     = {}
  @@destroy_action            = {}
  @@condition_destroy_action  = {}
  @@view_action               = {}
  @@condition_view_action     = {}
  @@options_link              = {}
  @@scopes                    = {}
  @@menus                     = []
  @@layout                    = {}
  @@index_path                = nil

  def self.edit_action
    if @@edit_action[self.to_s.to_sym] == false
      return false
    else
      return true
    end
  end
  
  def self.layout
    (@@layout[self.to_s.to_sym]) ? @@layout[self.to_s.to_sym] : []
  end
  
  def self.set_layout(desc,proc = nil)
    @@layout[self.to_s.to_sym] = [] unless @@layout[self.to_s.to_sym]
    @@layout[self.to_s.to_sym] = [desc,proc]
  end
  
  def self.condition_edit_action
    (@@condition_edit_action[self.to_s.to_sym]) ? @@condition_edit_action[self.to_s.to_sym] : nil
  end
  
  def self.destroy_action
    if @@destroy_action[self.to_s.to_sym] == false
      return false
    else
      return true
    end
  end
  
  def self.condition_destroy_action
    (@@condition_destroy_action[self.to_s.to_sym]) ? @@condition_destroy_action[self.to_s.to_sym] : nil
  end

  def self.view_action
    if @@view_action[self.to_s.to_sym] == false
      return false
    else
      return true
    end
  end
  
  def self.condition_view_action
    (@@condition_view_action[self.to_s.to_sym]) ? @@condition_view_action[self.to_s.to_sym] : nil
  end

  def self.root_path
    "/crud/#{self.to_s.gsub('Crud', '').underscore}"
  end

  def self.index_path str
    @@index_path = str
  end
  
  def self.get_index_path
    @@index_path
  end

  def self.title
    @@title[self.to_s.to_sym]
  end

  def self.subtitle(type)
    case type
    when :index
      @@subtitle_index[self.to_s.to_sym]
    end
  end

  def self.description(type)
    case type
    when :index
      @@description_index[self.to_s.to_sym]
    end
  end

  def self.top_links 
    (@@top_links[self.to_s.to_sym]) ? @@top_links[self.to_s.to_sym] : []
  end

  def self.index_fields
    (@@index_fields[self.to_s.to_sym]) ? @@index_fields[self.to_s.to_sym] : []
  end

  def self.order_field
    (@@order_field[self.to_s.to_sym]).present? ? @@order_field[self.to_s.to_sym] : "id"
  end
  
  def self.per_page
    @@per_page[self.to_s.to_sym]
  end

  def self.actions
    (@@actions[self.to_s.to_sym]) ? @@actions[self.to_s.to_sym] : []
  end

  def self.actions_links
    (@@links[self.to_s.to_sym]) ? @@links[self.to_s.to_sym] : []
  end

  def self.options_link
    (@@options_link[self.to_s.to_sym]) ? @@options_link[self.to_s.to_sym] : []
  end

  def self.form_fields
    (@@form_fields[self.to_s.to_sym]) ? @@form_fields[self.to_s.to_sym]  : []
  end

  def self.form_groups
    (@@form_group[self.to_s.to_sym]) ? @@form_group[self.to_s.to_sym]  : []
  end

  def self.form_scripts
    (@@form_scripts[self.to_s.to_sym]) ? @@form_scripts[self.to_s.to_sym]  : []
  end

  def self.view_fields
    (@@view_fields[self.to_s.to_sym]) ? @@view_fields[self.to_s.to_sym]  : []
  end

  def self.search_fields
    (@@search_fields[self.to_s.to_sym]) ? @@search_fields[self.to_s.to_sym]  : []
  end

  def self.test_fields
    (@@test_fields[self.to_s.to_sym]) ? @@test_fields[self.to_s.to_sym]  : []
  end
  
  def self.scopes
    (@@scopes[self.to_s.to_sym]) ? @@scopes[self.to_s.to_sym]  : []
  end

  def self.add_menus(menu)
    @@menus << menu
  end

  def self.menus
    @@menus
  end
  
  
  private
  
  def self.modelo
    self.to_s.underscore.gsub("_crud", "")
  end
  
  def self.titulo str
    @@title[self.to_s.to_sym] = str
  end

  def self.subtitulo(str,type)
    case type
    when :index
      @@subtitle_index[self.to_s.to_sym] = str
    end
  end

  def self.descricao(str,type)
    case type
    when :index
      @@description_index[self.to_s.to_sym] = str
    end
  end

  def self.link_superior nome, opts
      @@top_links[self.to_s.to_sym] = [] unless @@top_links[self.to_s.to_sym]
      @@top_links[self.to_s.to_sym].push(
          {
            text: nome,
            id:   opts[:id],
            data: {push: 'partial', target: '#form'},
            icon: "fa fa-#{opts[:icon]}",
            class: 'btn btn-small btn-primary btn-rounded',
            link: "#{opts[:link]}",
            url: opts[:url],
            can: opts[:can],
            partial: opts[:partial]
          }
    )
  end 
  
  def self.campo_tabela nome, opts
    @@index_fields[self.to_s.to_sym] = [] unless @@index_fields[self.to_s.to_sym]
    @@index_fields[self.to_s.to_sym].push(
      {
        attribute: nome
      }.merge(opts)
    )
  end
  
  def self.ordenar_por nome
    @@order_field[self.to_s.to_sym] = nome
  end
  
  def self.itens_por_pagina qtd
    @@per_page[self.to_s.to_sym] = qtd
  end
  
  def self.campo_teste nome, opts
    @@test_fields[self.to_s.to_sym] = [] unless @@test_fields[self.to_s.to_sym]
    @@test_fields[self.to_s.to_sym].push(
      {
        attribute: nome
      }.merge({sf: opts})
    )
  end   
  
  def self.campo_formulario nome, opts
    @@form_fields[self.to_s.to_sym] = [] unless @@form_fields[self.to_s.to_sym]
    if opts.present? && opts[:autocomplete].present?
      opts[:as] = :autocomplete
      label_method = opts[:autocomplete][:label_method] || opts[:autocomplete][:campo]
      opts[:url] = "/crud/#{opts[:autocomplete][:classe]}/autocomplete?campo=#{opts[:autocomplete][:campo]}&tipo=start&label=#{label_method}"
      name = "#{opts[:autocomplete][:campo]}_#{opts[:autocomplete][:classe]}"
      opts[:input_html] = {name: name, id: name}
      opts[:id_element] = "##{self.modelo}_#{nome}_id"
    end
    if opts.present? && opts[:grupo].present?
      opts[:fields] = []
      opts[:grupo].each do |field|
        attribute = field[:campo]
        field.delete(:campo)
        add_group_formulario(field) if field[:grupo].present?
        opts[:fields].push({attribute: attribute,sf: field})
      end
      opts[:grupo] = true if opts[:grupo].present?
    end
    @@form_fields[self.to_s.to_sym].push(
      {
        attribute: nome
      }.merge({sf: opts})
    )
    if opts.present? && opts[:autocomplete].present?
      campo_formulario(nome, {as: :hidden})
    end
  end
  
  private 
  def self.add_group_formulario(field)
    field[:fields] = []
    field[:grupo].each do |f|
      attribute = f[:campo]
      f.delete(:campo)
      add_group_formulario(f) if f[:grupo].present?
      field[:fields].push({attribute: attribute, sf: f})
    end
    field[:grupo] = true
  end

  public
  def self.campo_visualizacao nome, opts = nil
    @@view_fields[self.to_s.to_sym] = [] unless @@view_fields[self.to_s.to_sym]
    @@view_fields[self.to_s.to_sym].push(
      {
        attribute: nome
      }.merge({sf: opts})
    )
  end    

  def self.campo_busca nome, opts = nil
    @@search_fields[self.to_s.to_sym] = [] unless @@search_fields[self.to_s.to_sym]
    @@search_fields[self.to_s.to_sym].push(
      {
        attribute: nome
      }.merge({sf: opts})
    )
  end    
  
  def self.sem_visualizacao
    @@view_action[self.to_s.to_sym] = false
  end
  
  def self.visualizacao(condicao)
    @@condition_view_action[self.to_s.to_sym] = condicao
  end

  def self.sem_edicao
    @@edit_action[self.to_s.to_sym] = false
  end
  
  def self.edicao(condicao)
    @@condition_edit_action[self.to_s.to_sym] = condicao
  end

  def self.sem_exclusao
    @@destroy_action[self.to_s.to_sym] = false
  end
  
  def self.exclusao(condicao)
    @@condition_destroy_action[self.to_s.to_sym] = condicao
  end
  
  def self.acoes(method,desc,proc = nil)
    @@actions[self.to_s.to_sym] = [] unless @@actions[self.to_s.to_sym]
    @@actions[self.to_s.to_sym].push([method,desc,proc])
  end
  
  def self.links(name,options)
    @@links[self.to_s.to_sym] = [] unless @@links[self.to_s.to_sym]
    @@links[self.to_s.to_sym].push([name,options])
  end
  
  def self.opcoes(link,desc,proc = nil)
    @@options_link[self.to_s.to_sym] = [] unless @@options_link[self.to_s.to_sym]
    @@options_link[self.to_s.to_sym].push([link,desc,proc])
  end
  
  def self.escopos(scopes)
    @@scopes[self.to_s.to_sym] = scopes
  end
  
  def self.grupo_formulario(attribute,name,fields=nil)
    if fields.nil?
      fields = name
      name = attribute.to_s.singularize.titleize
    end
    @@form_group[self.to_s.to_sym] ||= {}
    @@form_group[self.to_s.to_sym][attribute] = {label: name, fields: []}
    fields.each do |field|
      value = {}
      field.each do |atr|
        if atr[0] == :campo
          value[:attribute] = atr[1]
        else
          value[:sf] ||= {}
          value[:sf][atr[0]] = atr[1]
        end
      end
      @@form_group[self.to_s.to_sym][attribute][:fields].push({attribute: value[:attribute],sf: value[:sf]})
    end
  end
  
  def self.adicionar_endereco
    @@form_fields[self.to_s.to_sym] = [] unless @@form_fields[self.to_s.to_sym]
    opts = {}
    opts[:fields] = []
    [
     {campo: :cep,  label: "CEP"},
     {campo: :logradouro,  label: "Endereço"},
     {campo: :numero,  label: "Número"},
     {campo: :complemento,  label: "Complemento"},
     {campo: :bairro,  label: "Bairro"},
     {campo: :estado,  label: "Estado", collection: Estado.order(:sigla).pluck(:sigla)},
     {campo: :cidade_id,  label: "Cidade", collection_if: Proc.new{|f| f.try(:object).try(:estado).try(:present?) ? (f.try(:object).try(:estado).try(:cidades) || []) : []}}
    ].each do |field|
      attribute = field[:campo]
      field.delete(:campo)
      opts[:fields].push({attribute: attribute,sf: field})
    end
    opts[:grupo] = true
    @@form_fields[self.to_s.to_sym].push(
      {
        attribute: :endereco
      }.merge({sf: opts})
    )
    @@form_scripts[self.to_s.to_sym] ||= []
    @@form_scripts[self.to_s.to_sym] << "cidade_estado"
  end
  
  def self.script_formulario(script)
    @@form_scripts[self.to_s.to_sym] ||= []
    @@form_scripts[self.to_s.to_sym] << script.to_s
  end

end