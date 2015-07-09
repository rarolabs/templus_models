class Teste < ActiveRecord::Base
  has_many :teste1
  scope :raro, -> {where("nome like '%raro%'")}
  scope :nao_raro, -> {where("nome not like '%raro%'")}
  accepts_nested_attributes_for :teste1, allow_destroy: true
  validates_presence_of :nome
  def to_s
    nome
  end
end
