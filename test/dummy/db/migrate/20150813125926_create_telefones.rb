class CreateTelefones < ActiveRecord::Migration
  def change
    create_table :telefones do |t|
      t.string :numero
      t.references :contato, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
