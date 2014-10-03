class CreateNotificacions < ActiveRecord::Migration
  def change
    create_table :notificacions do |t|
      t.boolean :notificado
      t.references :suscripcion_tema, index: true
      t.references :tema_comentario, index: true
      t.timestamps
    end
  end
end
