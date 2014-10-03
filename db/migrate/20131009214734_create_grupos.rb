class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nombre
      t.text :descripcion
      t.boolean :estado
      t.boolean :habilitado
      t.string :llave
      t.references :tema, index: true
      t.references :usuario, index: true

      t.timestamps
    end
  end
end
