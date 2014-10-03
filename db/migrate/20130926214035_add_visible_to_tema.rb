class AddVisibleToTema < ActiveRecord::Migration
  def change
    add_column :temas, :visible, :int, default: 1, null: false
  end
end
