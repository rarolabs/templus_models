class Teste1 < ActiveRecord::Base
  belongs_to :teste
  
  accepts_nested_attributes_for :teste
  def to_s
    descricao
  end
end
