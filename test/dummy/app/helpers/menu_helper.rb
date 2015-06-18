module MenuHelper
  def is_active(controller_name, action_name)
    (params[:controller] == controller_name && params[:action] == action_name) ? "active" : ""
  end  

  def is_active_crud(modelo)
    (controller.controller_name == 'crud' && params[:model] == modelo) ? "active" : ""
  end  
  
  def is_active_parent(controllers)
    controllers.each do |name|
      if (params[:controller] == name[0] && (params[:action] == name[1] || params[:model] == name[1])) 
        return "active"
      end
    end
    return ""
  end
  
  def is_can?(tipo, modelos)
    modelos.each do |m|
      if can?(tipo, m)
        return true
      end
    end
    return false
  end
  
  def menu_crud_helper(nome, classe, icon='', parent=false)
    if can?(:read, classe)
      modelo = classe.name.underscore
      url = "/crud/#{modelo}"
      buffer = ""
      buffer << "<li class='menu #{is_active_crud(modelo)}'>"
      if parent
        buffer << link_to("<i class='#{icon}'></i> <span>#{nome}</span>".html_safe, url, data: {push: true, crumb: 'wielka'})
      else
        buffer << link_to("<i class='#{icon}'></i> #{nome}".html_safe, url, data: {push: true, crumb: 'wielka'})
      end
      buffer << "</li>"
      buffer.html_safe
    end
  end
  
  def menu_helper(classe, controller, action, url, nome, icone='', parent=false)
   if can?(:read, classe)
      buffer = ""
  		buffer << "<li class='menu #{is_active(controller, action)}'>"
      if parent
        buffer << link_to("<i class='#{icone}'></i> <span>#{nome}</span>".html_safe, url, data: {push: true, crumb: 'wielka'})
      else
        buffer << link_to("<i class='#{icone}'></i> #{nome}".html_safe, url, data: {push: true, crumb: 'wielka'})
      end
      buffer << "</li>"
      buffer.html_safe
   end
  end
  
  def menu_parent(modelos, controllers, nome, icone='', parent=false, &block)
    if is_can?(:read, modelos)
      buffer = ""
      buffer << "<li class='parent-menu #{is_active_parent(controllers)}'>"
      if parent
        buffer << "<a><i class='#{icone}'></i> <span>#{nome}</span><span class='fa arrow'></span></a>".html_safe
      else
        buffer << "<a><i class='#{icone}'></i> #{nome}<span class='fa arrow'></span></a>".html_safe
      end
      buffer << "<ul class='nav nav-second-level collapse'>"
      buffer << capture(&block)
      buffer << "</ul>"
      buffer << "</li>"
      buffer.html_safe
    end
  end

  def menu_parent_second(modelos, controllers, nome, icone='', &block)
    if is_can?(:read, modelos)
      buffer = ""
      buffer << "<li class='parent-menu #{is_active_parent(controllers)}'>"
      buffer << "<a><i class='#{icone}'></i> #{nome}<span class='fa arrow'></span></a>".html_safe
      buffer << "<ul class='nav nav-third-level collapse'>"
      buffer << capture(&block)
      buffer << "</ul>"
      buffer << "</li>"
      buffer.html_safe
    end
  end
end