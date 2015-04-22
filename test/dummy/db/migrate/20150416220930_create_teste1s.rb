class CreateTeste1s < ActiveRecord::Migration
  def change
    create_table :teste1s do |t|
      t.string :descricao
      t.references :teste, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
