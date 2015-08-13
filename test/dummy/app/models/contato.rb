class Contato < ActiveRecord::Base
  has_many :telefones
  accepts_nested_attributes_for :telefones, :allow_destroy => true
  
end
