class CreateAdjuntoRespuestaCuestionarios < ActiveRecord::Migration
  def change
    create_table :adjunto_respuesta_cuestionarios do |t|
      t.references :respuesta_usuario, index: true

      t.timestamps
    end
    add_attachment :adjunto_respuesta_cuestionarios, :archivo
  end
end
