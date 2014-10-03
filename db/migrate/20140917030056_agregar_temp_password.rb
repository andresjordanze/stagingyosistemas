class AgregarTempPassword < ActiveRecord::Migration
  def change
  	add_column :usuarios, :temp_password, :string
  end
end
