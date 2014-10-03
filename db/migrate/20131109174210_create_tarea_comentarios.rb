class CreateTareaComentarios < ActiveRecord::Migration
  def change
    create_table :tarea_comentarios do |t|
      t.text :cuerpo
      t.references :tarea, index: true
      t.references :usuario, index: true
      t.timestamps
    end
  end
end
