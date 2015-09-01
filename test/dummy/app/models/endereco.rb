class Endereco < ActiveRecord::Base
  belongs_to :cidade
  delegate :estado, to: :cidade, allow_nil: true
  belongs_to :usuario, :class_name => "Usuario", :foreign_key => "usuario_id"
  validates_associated :cidade
  validates_presence_of :logradouro, :numero, :cep, :bairro, :cidade_id, :estado
  def to_s
    if logradouro.present?
      "#{logradouro}, #{numero} #{complemento}, #{bairro}, #{cidade.try(:cidade_estado)}"
    end
  end
end
