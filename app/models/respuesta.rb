class Respuesta < ActiveRecord::Base
  self.table_name = 'respuestas'
  belongs_to :pregunta
end
