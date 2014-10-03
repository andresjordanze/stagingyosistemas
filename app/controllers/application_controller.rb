class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :require_log_in
  helper_method :notificaciones

  private
  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
  def require_log_in
    unless current_user
      redirect_to root_path
    end
  end

  def notificaciones
    @notificaciones = Array.new
    if current_user!=nil
      suscripciones = SuscripcionTema.where(:usuario_id=>current_user.id)
      suscripciones.each do |suscripcion|
        notificacionesTodo = Notificacion.where(:suscripcion_tema_id=>suscripcion.id,:notificado=>false)
        notificacionesTodo.each do |notificacion|
          @notificaciones.push (notificacion)
        end
      end
    end
    @notificaciones

    
  end
end