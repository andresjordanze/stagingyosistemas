class TemaComentario < ActiveRecord::Base
  belongs_to :tema
  belongs_to :usuario
  has_many :notificacions
  has_many :adjunto_tema_comentarios
  validates :cuerpo, :presence => true
end
