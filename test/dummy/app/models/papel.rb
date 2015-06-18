class Papel < ActiveRecord::Base
  has_many :usuarios
  has_many :permissoes, dependent: :destroy
  validates_presence_of :descricao, :nome, :chave
  validates_uniqueness_of :chave

  accepts_nested_attributes_for :permissoes, allow_destroy: true

  def to_s
    self.nome
  end

end
