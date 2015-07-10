class Teste1 < ActiveRecord::Base
  belongs_to :teste
  
  accepts_nested_attributes_for :teste, allow_destroy: true
  def to_s
    descricao
  end
end
