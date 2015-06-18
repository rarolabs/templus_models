class UsuariosController < ApplicationController
  def edit
    @model = Module.const_get("usuario".camelize)
    @crud_helper = Module.const_get("usuario_crud".camelize)
    @usuario = Usuario.find(params[:id])
  end  
  
  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(Usuario.allowed(params))
      flash[:success] = "Usuário alterado com sucesso."
      redirect_to :root
    else
      @model = Module.const_get("usuario".camelize)
      @crud_helper = Module.const_get("usuario_crud".camelize)
      render action: :edit
    end
  end
end