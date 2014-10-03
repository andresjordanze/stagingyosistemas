class CreatePregunta < ActiveRecord::Migration
  def change
    create_table :pregunta do |t|
      t.references :cuestionario, index: true
      t.string :texto
      t.string :tipo

      t.timestamps
    end
  end
end
