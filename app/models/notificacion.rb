class Notificacion < ActiveRecord::Base
  belongs_to :tema_comentario
  belongs_to :suscripcion_tema
end
