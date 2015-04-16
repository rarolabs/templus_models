class CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def copy_initializer_file
      copy_file "crud.rb", "app/raro_crud/#{file_name}_crud.rb"
  end
    
end
