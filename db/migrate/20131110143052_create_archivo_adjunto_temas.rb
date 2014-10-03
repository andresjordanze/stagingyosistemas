class CreateArchivoAdjuntoTemas < ActiveRecord::Migration
  def change
    create_table :archivo_adjunto_temas do |t|
      t.references :tema, index: true

      t.timestamps
    end
    add_attachment :archivo_adjunto_temas, :archivo
  end
end
