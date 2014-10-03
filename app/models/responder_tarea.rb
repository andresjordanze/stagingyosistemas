class ResponderTarea < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :grupo
  belongs_to :tarea
  has_many :archivo_adjunto_respuestas
  validates :descripcion, :presence => {:message => " es requerida"}
  def self.ya_envio_tarea(usuario,tarea)
  		!ResponderTarea.where(:usuario_id => usuario,:tarea_id => tarea).first.nil?
  end
end
