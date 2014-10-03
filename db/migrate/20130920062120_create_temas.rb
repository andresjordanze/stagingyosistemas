class CreateTemas < ActiveRecord::Migration
  def change
    create_table :temas do |t|
      t.string :titulo
      t.text :cuerpo
      t.references :usuario, index: true
      t.timestamps
    end
  end
end