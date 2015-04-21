class CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  attr_reader :teste
  
  def copy_initializer_file
      @model = Module.const_get(file_name.camelize)
      template 'crud.rb', "app/raro_crud/#{file_name}_crud.rb", @model
  end
    
end
