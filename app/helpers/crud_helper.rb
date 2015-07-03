module CrudHelper
  
  def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
  end
  
  def is_raro_crud(attribute)
    #if(Rails.env == "production")
    #  @@cruds = Dir[Rails.root.join("app","raro_crud","*.rb")].map{|f| f.split(/\//).last.gsub(/_crud\.rb/,'')} unless @@cruds
    #else
      @@cruds = Dir[Rails.root.join("app","raro_crud","*.rb")].map{|f| f.split(/\//).last.gsub(/_crud\.rb/,'')}
    #end
    return @@cruds.include?(attribute.to_s)
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
  
  
  def render_link(link)
    "<a href='#{link[:link]}' class='#{link[:class]}' #{data(link)}>#{gen_icon(link[:icon])} #{link[:text]}</a>".html_safe
  end

  def gen_icon(i)
    if i
      "<i class='#{i}'></i>" 
    else
      ""
    end
  end

  def data(link)
    buffer = ""
    link[:data].each_key{|k| buffer << " data-#{k}='#{link[:data][k]}' "} if link[:data]
    return buffer
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

  def flash_messages_for
    tipo = ""
    case
      when flash[:notice]
        message = flash.discard(:notice)
        tipo = 'notice'
      when flash[:alert]
        message = flash.discard(:alert)
        tipo = 'alert'
      when flash[:success]
        message = flash.discard(:success)
        tipo = 'success'
      when flash[:error]
        message = flash.discard(:error)
        tipo = 'error'
      when flash[:info]
        message = flash.discard(:info)
        tipo = 'info'
      end
      
    flash.clear
    
    if message.present?
      javascript_tag "mensagem_#{tipo}('#{message}')"
    end
  end

  def render_plus_button(field,f,modelo,record)
    field[:sf][:wrapper] = :with_button
    render_field(field,f,modelo,record)
  end
    
  def render_field(field,f,modelo,record)
    if field[:sf].present? && field[:sf][:if].present?
      return unless field[:sf][:if].call(f.object)
    end
    if !field[:sf][:edit].nil? || !field[:sf][:create].nil?
      if !field[:sf][:edit].nil? && !field[:sf][:edit] && !record.new_record?
      elsif !field[:sf][:create].nil? && !field[:sf][:create] && record.new_record? 
      else 
        unless modelo.reflect_on_association(field[:attribute]) 
           f.input field[:attribute], field[:sf]
        else 
           f.association field[:attribute], field[:sf]
        end 
      end 
    else
      if field[:sf][:value] and field[:sf][:value].class == Proc
         field[:sf][:input_html] ||= {} 
         field[:sf][:input_html][:value] = f.instance_eval &field[:sf][:value] 
      end
      if field[:sf][:collection_if] and field[:sf][:collection_if].class == Proc
         field[:sf][:collection] = f.instance_eval &field[:sf][:collection_if]
      end
      unless modelo.reflect_on_association(field[:attribute])
        f.input field[:attribute], field[:sf]
      else 
        f.association field[:attribute], field[:sf]
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
		if imagem?(field) && field.url(:thumb)
			image_tag(field.url(:thumb))
		elsif video?(field)
			link_to field, field.url, target: "_blank"
		else
			link_to field, field.url, target: "_blank"
		end
  end
end