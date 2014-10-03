class CreateTareas < ActiveRecord::Migration
  def change
    create_table :tareas do |t|
      t.string :titulo
      t.string :descripcion
      t.date :fecha_entrega
      t.references :grupo, index: true
      t.references :usuario, index: true
      t.timestamps
    end
  end
end
