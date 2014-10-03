class CreateSuscripcionTemas < ActiveRecord::Migration
  def change
    create_table :suscripcion_temas do |t|
      t.references :tema, index: true
      t.references :usuario, index: true
      t.timestamps
    end
  end
end
