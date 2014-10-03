class Mensaje < ActiveRecord::Base	
	belongs_to :de_usuario, class_name:'Usuario'
    belongs_to :para_usuario, class_name:'Usuario'
end
