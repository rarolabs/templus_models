class Api::CidadesController < ApplicationController
  def busca
    respond_to do |format|
      @estado = Estado.find_by(sigla: params[:estado])
      puts "*******************************************"
      p @estado
      puts "*******************************************"
      @cidades = Cidade.por_estado(@estado.try(:id))
      format.json  { render json: @cidades }
    end
  end
end