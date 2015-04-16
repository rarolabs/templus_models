class Ability
  include CanCan::Ability

  def initialize(usuario)
    # usuario ||= Usuario.new
    #
    # alias_action :index, :show, :to => :read
    # alias_action :new, :to => :create
    # alias_action :edit, :to => :update
    # # alias_action :limpar, :to => :create_or_update
    # # alias_action :destroy_selected, :to => :destroy
    #
    # if usuario.root?
    #   can :manage, :all
    # else
    #   #Permissão global
    #   can :manage, Dashboard
    #
    #   # #Permissão fixa
    #   # case usuario.papel.chave
    #   #   when "admin"
    #   # end
    #
    #   #Permissão dinamica
    #   usuario.papel.permissoes.each do |permissao|
    #     if usuario.papel.reference_id.present? && permissao.klass.constantize.method_defined?(:reference_id)
    #       can permissao.abilities, permissao.klass.constantize
    #     else
    #       can permissao.abilities, permissao.klass.constantize, reference_id: usuario.papel.reference_id
    #     end
    #   end
    # end
    #Condições especificas de autorização
  end
end
