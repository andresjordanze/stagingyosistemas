class CreateArchivoAdjuntoComentarios < ActiveRecord::Migration
  def change
    create_table :archivo_adjunto_comentarios do |t|

      t.timestamps
    end
  end
end
