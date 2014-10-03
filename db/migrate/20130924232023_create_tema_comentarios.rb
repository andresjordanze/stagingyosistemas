class CreateTemaComentarios < ActiveRecord::Migration
  def change
    create_table :tema_comentarios do |t|
      t.text :cuerpo
      t.references :tema, index: true
      t.references :usuario, index: true
      t.timestamps
    end
  end
end
