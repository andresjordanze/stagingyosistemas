class CreateCuestionarios < ActiveRecord::Migration
  def change
    create_table :cuestionarios do |t|
      t.string :titulo
      t.text :descripcion
      t.datetime :fecha_limite
      t.boolean :estado
      t.references :grupo, index: true
      t.references :usuario, index: true

      t.timestamps
    end
  end
end
