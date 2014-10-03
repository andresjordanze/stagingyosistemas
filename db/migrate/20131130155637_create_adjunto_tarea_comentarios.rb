class CreateAdjuntoTareaComentarios < ActiveRecord::Migration
  def change
    create_table :adjunto_tarea_comentarios do |t|
      t.references :tarea_comentario, index: true

      t.timestamps
    end
    add_attachment :adjunto_tarea_comentarios, :archivo
  end
end
