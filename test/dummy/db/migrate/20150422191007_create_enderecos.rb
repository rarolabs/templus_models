class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :cep
      t.string :logradouro
      t.string :complemento
      t.string :numero
      t.string :bairro
      t.references :cidade, index: true, foreign_key: true
      t.references :usuario, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
