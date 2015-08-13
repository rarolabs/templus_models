class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :nome
      t.string :email
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
