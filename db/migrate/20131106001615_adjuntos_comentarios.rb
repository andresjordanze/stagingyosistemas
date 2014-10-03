class AdjuntosComentarios < ActiveRecord::Migration
  def change
  	  create_table :adjuntos_comentarios do |t|
      t.references :tema_comentario, index: true
      t.timestamps
    end
    add_attachment :adjuntos_comentarios, :archivo
  end
end