class NotificacionGrupo < ActiveRecord::Base
  belongs_to :subscripcion
  belongs_to :tarea
end
