class Usuario < ActiveRecord::Base

  validates_presence_of :nome, :email
  has_one :endereco, :class_name => "Endereco", :foreign_key => "usuario_id"
  accepts_nested_attributes_for :endereco, :allow_destroy => true

  def to_s
    nome
  end

  def ability
    @ability ||= Ability.new(self)
  end
  
  def self.current
    return Thread.current[:current_usuario]
  end
  
  def self.current=(usuario)
    Thread.current[:current_usuario] = usuario
  end
end
