class Cidade < ActiveRecord::Base
  belongs_to :estado
  scope :por_estado, -> (estado_id) {where(estado_id: estado_id)}
  def to_s
    nome
  end
end
