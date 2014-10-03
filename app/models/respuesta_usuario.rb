class RespuestaUsuario < ActiveRecord::Base
  belongs_to :cuestionario
  belongs_to :usuario
  belongs_to :pregunta
  has_many :adjunto_respuesta_cuestionarios
  def self.ya_respondio_cuestionario(usuario,cuestionario)
  		!RespuestaUsuario.where(:usuario_id => usuario,:cuestionario_id=> cuestionario).first.nil?
  end
end
