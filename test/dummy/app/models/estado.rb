class Estado < ActiveRecord::Base
  has_many :cidades, :class_name => "Cidade", :foreign_key => "estado_id"
  def to_s
    sigla
  end
end
