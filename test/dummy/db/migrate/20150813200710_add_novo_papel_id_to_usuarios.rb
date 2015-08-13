class AddNovoPapelIdToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :novo_papel_id, :integer
  end
end
