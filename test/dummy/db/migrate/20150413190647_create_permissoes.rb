class CreatePermissoes < ActiveRecord::Migration
  def change
    create_table :permissoes do |t|
      t.boolean :can_read
      t.boolean :can_create
      t.boolean :can_update
      t.boolean :can_destroy
      t.boolean :can_manage
      t.string :klass
      t.references :papel, index: true
      t.timestamps
    end
  end
end
