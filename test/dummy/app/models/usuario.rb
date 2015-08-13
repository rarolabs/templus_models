class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # belongs_to :papel
  belongs_to :perfil, :class_name => "Papel", :foreign_key => "papel_id"
  validates_presence_of :nome, :email
  has_many :contatos
  
  accepts_nested_attributes_for :contatos, :allow_destroy => true
  
  

  def to_s
    nome
  end

  def self.params_permitt
    [:password, :password_confirmation]
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
