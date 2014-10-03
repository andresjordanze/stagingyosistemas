class TareaComentario < ActiveRecord::Base
  belongs_to :tarea
  belongs_to :usuario
  has_many :adjunto_tarea_comentarios
  validates :cuerpo, :presence => { :message => " es requerido" }
end
