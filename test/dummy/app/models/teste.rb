class Teste < ActiveRecord::Base
  has_one :teste1
  scope :raro, -> {where("nome like '%raro%'")}
  scope :nao_raro, -> {where("nome not like '%raro%'")}
  
  def to_s
    nome
  end
end
