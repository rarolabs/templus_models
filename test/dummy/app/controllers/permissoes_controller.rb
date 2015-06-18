class PermissoesController < ApplicationController
  @permissao = "Permissao"
  authorize_resource class: @permissao

  def create
    papel = Papel.find(params[:papel_id])
    papel.permissoes.destroy_all
    papel.update_attributes(papel_params)
    redirect_to "/crud/papel", notice: "Papel atualizado com sucesso."
  end
  
  private
  def papel_params
    params.require(:papel).permit!
  end
end