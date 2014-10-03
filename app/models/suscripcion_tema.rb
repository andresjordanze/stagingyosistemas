class SuscripcionTema < ActiveRecord::Base
  belongs_to :tema
  belongs_to :usuario
  has_many :notificacions
end
