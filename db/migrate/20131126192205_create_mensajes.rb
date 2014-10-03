class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.integer :de_usuario_id
      t.integer :para_usuario_id
      t.string :mensaje
      t.boolean :visto , default: false
      t.timestamps
    end
  end
end
