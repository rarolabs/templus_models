class BrancoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_reader :teste
  argument :acao, type: :string, default: [], banner: "action action"
  
  def copy_initializer_file
      @model = Module.const_get(file_name.camelize)
      @action = acao
      template 'template.rb', "app/views/#{@model.name.pluralize.underscore.to_sym}/_template.html.erb", @model,@action
      template 'action.rb', "app/views/#{@model.name.pluralize.underscore.to_sym}/#{@action}.html.erb", @model,@action
      template 'action_partial.rb', "app/views/#{@model.name.pluralize.underscore.to_sym}/_#{@action}.html.erb", @model,@action
  end
end
