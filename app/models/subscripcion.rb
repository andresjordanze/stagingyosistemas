class Subscripcion < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :grupo
  has_many :notificacion_grupos

  def verificar_llave(llave_grupo)
    return self.llave == llave_grupo
  end
end
