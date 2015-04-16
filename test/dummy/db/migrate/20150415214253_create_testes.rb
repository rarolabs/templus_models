class CreateTestes < ActiveRecord::Migration
  def change
    create_table :testes do |t|
      t.string :nome

      t.timestamps
    end
  end
end
