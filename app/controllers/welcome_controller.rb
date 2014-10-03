class WelcomeController < ApplicationController
  skip_before_filter :require_log_in
  before_filter :grupos
  def index
  end
  def grupos
   if(params[:id] != nil && Grupo.find(params[:id]).habilitado)
    @grupo = Grupo.find(params[:id])
  else
    @grupo = Grupo.find(1)
 end
 end
end
