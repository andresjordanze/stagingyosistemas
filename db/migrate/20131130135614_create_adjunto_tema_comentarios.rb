class CreateAdjuntoTemaComentarios < ActiveRecord::Migration
  def change
    create_table :adjunto_tema_comentarios do |t|
      t.references :tema_comentario, index: true

      t.timestamps
    end
    add_attachment :adjunto_tema_comentarios, :archivo
  end
end
