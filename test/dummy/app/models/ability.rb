class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new

    alias_action :index, :show, :query, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update
    alias_action :action, :to => :create_or_update
    # alias_action :destroy_selected, :to => :destroy

    if usuario.root?
      can :manage, :all
    else
      #Permissão global
      can :manage, Dashboard

      # #Permissão fixa
      # case usuario.papel.chave
      #   when "admin"
      # end

      #Permissão dinamica
      if usuario.papel
        usuario.papel.permissoes.each do |permissao|
          # if usuario.reference_id.present? && permissao.klass.constantize.attribute_method?(:reference_id)
            can permissao.abilities, permissao.klass.constantize, reference_id: usuario.reference_id
          # else
            # can permissao.abilities, permissao.klass.constantize
          # end
        end
      end
    end
    #Condições especificas de autorização
  end
end
