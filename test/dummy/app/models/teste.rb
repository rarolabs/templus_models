class Teste < ActiveRecord::Base
  scope :raro, -> {where("nome like '%raro%'")}
  scope :nao_raro, -> {where("nome not like '%raro%'")}
end
