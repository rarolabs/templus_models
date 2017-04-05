module CrudHelper

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def is_raro_crud(classe)
    #if(Rails.env == "production")
    #  @@cruds = Dir[Rails.root.join("app","raro_crud","*.rb")].map{|f| f.split(/\//).last.gsub(/_crud\.rb/,'')} unless @@cruds
    #else
      @@cruds = Dir[Rails.root.join("app","raro_crud","*.rb")].map{|f| f.split(/\//).last.gsub(/_crud\.rb/,'')}
    #end
    return @@cruds.include?(classe.underscore.to_s)
  end

  def lista_menus_crud(raro_models)
    menus = []
    raro_models.each do |modelo|
      menus << ['crud', "#{modelo.name.underscore}"]
    end
    menus
  end

  def menu_helper_crud(modelo, url, nome, classe, icon='')
    if can?(:read, classe)
      buffer = ""
      buffer << "<li class='childreen #{controller.controller_name == 'crud' and params[:model] == modelo ? 'active' : '' }'>"
      buffer << link_to("<i class='#{icon}'></i><span>#{nome}</span>".html_safe, url, data: {push: true, crumb: 'wielka'})
      buffer << "</li>"
      buffer.html_safe
    end
  end

  def is_action_edit?
    params[:action] == "edit"
  end

  def is_action_create?
    params[:action] == "create"
  end

  def is_action_show?
    params[:action] == "show"
  end

  def is_action_new?
    params[:action] == "new"
  end

  def is_action_index?
    params[:action] == "index"
  end

  def is_action_query?
    params[:action] == "query"
  end


  def render_link(link,url)
    nome_modelo = I18n.t("model.#{link[:modelo].underscore}")
    if link[:partial].present?
      render link[:partial]
    elsif link[:link].present?
      link_to "#{gen_icon(link[:icon])} #{I18n.t(link[:text], model: nome_modelo)}".html_safe, "#{url}/#{link[:link]}", class: link[:class], data: data(link)
    else
      link_to "#{gen_icon(link[:icon])} #{I18n.t(link[:text], model: nome_modelo)}".html_safe, link[:url], class: link[:class], data: data(link)
    end
  end

  def gen_icon(i)
    if i
      "<i class='#{i}'></i>"
    else
      ""
    end
  end

  def data(link)
    data = {}
    link[:data].each_key{|k| data[k] = link[:data][k]} if link[:data]
    return data
  end

  def raro_models
    models = []
    Dir["#{Rails.root.to_s}/app/raro_crud/*"].each do |f|
      m = f.split("/").last.split("_crud").first.camelize
      if m != "Raro"
        models << m.constantize
      end
    end
    models.uniq.flatten
  end

  def raro_permissions
    permissions = []
    Dir["#{Rails.root.to_s}/app/controllers/*"].each do |f|
      permission = f.split("/").last.split(".").first.camelize.constantize.instance_variable_get("@permissao")
      if permission.present?
        permissions << permission
      end
    end
    raro_models.each do |m|
      permissions << m.name
    end
    permissions.uniq.flatten
  end

  def render_plus_button(field, f, modelo, record, options = {})
    field[:sf][:wrapper] = options[:wrapper] || :with_button
    render_field(field, f, modelo, record)
  end

  def render_field(field, f, modelo, record)
    field[:sf][:wrapper] ||= :default
    if field[:sf].present? && field[:sf][:if].present?
      return unless field[:sf][:if].call(f.object)
    end
    field[:sf][:hint] = false if field[:sf].present? && !field[:sf][:hint].present?
    if field[:sf].present? && field[:sf][:date_format].present? && f.object.send(field[:attribute]).present? && Date <= modelo.columns_hash[field[:attribute].to_s].type.to_s.camelcase.constantize
      field[:sf][:input_html] ||= {}
      field[:sf][:input_html][:value] = f.object.send(field[:attribute]).strftime(field[:sf][:date_format])
    end
    if !field[:sf][:edit].nil? || !field[:sf][:create].nil?
      if !field[:sf][:edit].nil? && !field[:sf][:edit] && !record.new_record?
      elsif !field[:sf][:create].nil? && !field[:sf][:create] && record.new_record?
      else
        opts = field[:sf].merge(label: I18n.t(field[:sf][:label]))
        unless modelo.reflect_on_association(field[:attribute])
          if modelo.new.send(field[:attribute]).class.to_s =~ /Uploader/ and f.object.send(field[:attribute]).present?
            f.input field[:attribute], opts.merge(hint: "Arquivo Atual: #{f.object.send(field[:attribute]).file.filename}")
          else
            f.input field[:attribute], opts
          end
        else
           f.association field[:attribute], opts
        end
      end
    else
      if field[:sf][:value] and field[:sf][:value].class == Proc
         field[:sf][:input_html] ||= {}
         field[:sf][:input_html][:value] = f.instance_eval(&field[:sf][:value])
      end
      if field[:sf][:collection_if] and field[:sf][:collection_if].class == Proc
         field[:sf][:collection] = f.instance_eval(&field[:sf][:collection_if])
      end
      opts = field[:sf].merge(label: I18n.t(field[:sf][:label]))
      unless modelo.reflect_on_association(field[:attribute])
        if modelo.new.send(field[:attribute]).class.to_s =~ /Uploader/ and f.object.send(field[:attribute]).present?
          f.input field[:attribute], opts.merge(hint: "Arquivo Atual: #{f.object.send(field[:attribute]).file.filename}")
        else
          f.input field[:attribute], opts
        end
      else
        f.association field[:attribute], opts
      end
    end
  end

  def imagem?(file)
    file.present? && file.content_type.start_with?('image')
  end

  def video?(file)
    file.present? && file.content_type.start_with?('video')
  end

  def documento?(file)
    !(video?(file) || imagem?(file))
  end

  def render_field_file(field)
		if imagem?(field) && field.respond_to?(:thumb)
      if is_active_action("printing")
        pdf_image_tag(field, width: '100px')
      else
        image_tag(field.url(:thumb), width: '100px')
      end
		elsif video?(field)
			link_to field, field.url, target: "_blank"
		else
			link_to field, field.url, target: "_blank"
		end
  end

  def render_crud(&block)
    render "/crud/shared", block: block
  end

  def render_default_actions_crud
    render "default_actions_crud"
  end

  #Permissions
  def should_view?(crud_helper, record)
    return false unless can?(:read, record)
    return true if crud_helper.condition_view_action.nil?
    crud_helper.condition_view_action.call(record)
  end

  def should_edit?(crud_helper, record)
    return false unless can?(:update, record)
    return true if crud_helper.condition_edit_action.nil?
    crud_helper.condition_edit_action.call(record)
  end

  def should_destroy?(crud_helper, record)
    return false unless can?(:destroy, record)
    return true if crud_helper.condition_destroy_action.nil?
    crud_helper.condition_destroy_action.call(record)
  end

  def should_listing?(crud_helper, model)
    return false unless can?(:read, model)
    return true if crud_helper.condition_listing_action.nil?
    crud_helper.condition_listing_action.call(model)
  end

  def should_listing_excel?(crud_helper, model)
    return false unless can?(:read, model)
    return true if crud_helper.condition_listing_excel.nil?
    crud_helper.condition_listing_excel.call(model)
  end

  def should_listing_pdf?(crud_helper, model)
    return false unless can?(:read, model)
    return true if crud_helper.condition_listing_pdf.nil?
    crud_helper.condition_listing_excel.call(model)
  end

  def can_print_pdf?(crud_helper, record)
    return false unless can?(:read, record)
    return true if crud_helper.condition_printing_action.nil?
    crud_helper.condition_printing_action.call(record)
  end


  private

  def pdf_image_tag(field, options = {})
    if Rails.env.development? || Rails.env.test?
      # Unless running a web server that can process 2 requests at the same
      # time, trying to insert an image in a PDF creates a deadlock: the server
      # can't finish processing the PDF request until it gets the image, but it
      # can't start processing the image request until it has finished
      # processing the PDF request.
      # This will not be a problem in production, but in dev, a workaround is
      # to base64 the image and insert its contents into the HTML
      if field.respond_to?(:thumb)
        image_data = File.read(field.thumb.path)
      else
        image_data = Rails.application.assets[field].to_s
      end
      image_tag("data:image/png;base64,#{::Base64.encode64(image_data)}", options)
    else
      if field.respond_to?(:thumb)
        field = field.thumb.url
      end
      wicked_pdf_image_tag(field, options)
    end
  end
end
