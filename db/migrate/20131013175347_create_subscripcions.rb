class CreateSubscripcions < ActiveRecord::Migration
  def change
    create_table :subscripcions do |t|
      t.string :llave
      t.references :usuario, index: true
      t.references :grupo, index: true

      t.timestamps
    end
  end
end
