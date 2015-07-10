
module MensagensHelper
  def flash_messages_error(errors)
    if errors.present?
      render "/crud/mensagens/erros_formulario", mensagens: errors.full_messages
    end
  end

  def flash_messages
    message, tipo = extrair_mensagem
    if message.present? && tipo.present?
      render "/crud/mensagens/avisos", tipo: tipo, mensagem:  message
    end
  end
  
  def flash_messages_for
    message, tipo = extrair_mensagem
    if message.present? && tipo.present?
      javascript_tag "mensagem_#{tipo}('#{message}')"
    end
  end
  
  private
  def extrair_mensagem
    case
      when flash[:notice]
        message = flash.discard(:notice)
        tipo = 'warning'
      when flash[:alert]
        message = flash.discard(:alert)
        tipo = 'warning'
      when flash[:success]
        message = flash.discard(:success)
        tipo = 'success'
      when flash[:error]
        message = flash.discard(:error)
        tipo = 'danger'
      when flash[:info]
        message = flash.discard(:info)
        tipo = 'info'
      end  
    flash.clear
    return message, tipo
  end
end