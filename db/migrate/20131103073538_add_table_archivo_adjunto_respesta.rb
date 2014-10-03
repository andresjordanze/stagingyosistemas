class AddTableArchivoAdjuntoRespesta < ActiveRecord::Migration
  def change
    create_table :archivo_adjunto_respuestas do |t|
      t.references :responder_tarea, index: true
      t.timestamps
    end
    add_attachment :archivo_adjunto_respuestas, :archivo
  end
end