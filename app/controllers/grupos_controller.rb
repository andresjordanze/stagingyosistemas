class GruposController < ApplicationController
  attr_accessor :estado, :nombre
before_filter :grupos
  def index
    @grupos = Grupo.all_habilitados.page(params[:page]).per(5)
  end

  def mis_grupos
    @grupos = Grupo.buscar_mis_grupos(current_user)
    @grupos = Kaminari.paginate_array(@grupos).page(params[:page]).per(5)
  end

  def deshabilitar_grupo
    grupo = Grupo.find(params[:id])
    if current_user == grupo.usuario
      grupo.deshabilitar_grupo
    end
    redirect_to (:back)
  end

  def habilitar_grupo
    grupo = Grupo.find(params[:id])
    if current_user == grupo.usuario
      grupo.habilitar_grupo
    end
    redirect_to (:back)
  end
  
  def buscar
    @grupos=Array.new
    aux = Grupo.all_habilitados
    nombre = params[:nombre]
    if nombre != "" && nombre != nil
      aux.each do |grupo|
        if (grupo.correspondeAGrupo(nombre))
          @grupos.push(grupo)
        end
      end
    else
      @grupos = aux
    end
    @grupos = Kaminari.paginate_array(@grupos).page(params[:page]).per(5)
    render 'index'
  end

  def buscar_por_llave    
    
    aux = Grupo.all    
    llave = params[:llave]
    if llave != nil && llave != "publico"
      aux.each do |grupo| 
        if(grupo.llave==llave)
          subscrip = Subscripcion.new
          subscrip.grupo_id = grupo.id
          subscrip.usuario_id = current_user.id
          subscrip.save                    
          @grupo = grupo                              
        end  
      end 
      if @grupo == nil
        redirect_to root_path, :flash => { :info => "La llave que proporciono no pertenece a ningun grupo" }
      else
        redirect_to '/grupos/'+@grupo.id.to_s+'/temas-y-tareas/', :flash => { :info => "Se ha suscrito al grupo: "+"' "+ @grupo.nombre+" '"+" exitosamente" }     
      end            
    else    
      render 'index'
    end
  end

	def new
    if (current_user!=nil && current_user.rol=="Estudiante")
      redirect_to root_path
    else
      @grupo = Grupo.new
    end
  end

  def show
     @grupo = Grupo.find(params[:id])
  end

  def edit
    @grupo = Grupo.find(params[:id])
  end

  def update
    @grupo = Grupo.find(params[:id])
    if(@grupo.update(grupo_params))               
      redirect_to @grupo, :flash => { :alert => "Los datos del grupo han sido actualizados exitosamente." }
    else
      render 'edit'
    end
  end

  def create
    @grupo = Grupo.new(grupo_params)
    @grupo.usuario_id = current_user.id
    @grupo.verificar_grupo
    respond_to do |format|  
      if @grupo.save
        subs = Subscripcion.new
        subs.grupo = @grupo
        subs.usuario = current_user
        subs.save
        format.html { redirect_to @grupo, notice: 'Grupo ha sido creado.' }
      else
        #redirect_to "/grupos/new", :flash => { :error => "Error al crear un grupo" }
        render 'new', :flash => { :alert => "Error al crear un grupo" }
      end
    end
  end

  def subscripcion_grupo
    @grupo = Grupo.find(params[:id])
  end

  def suscriptores
    @grupo = Grupo.find(params[:id])
    @suscriptores = @grupo.subscripcions
  end

  def detalle_usuario
    @usuario = Usuario.find(params[:id])
  end

  def invitacion_grupo
    @grupo = Grupo.find(params[:id])
  end

  def enviar_invitaciones
    @grupo=Grupo.find(params[:id])
    correos=(params[:correos]).split(",")
    correos.each do |correo|
        SendMail.enviar_invitaciones(current_user, correo, @grupo).deliver
    end
    redirect_to '/grupos/invitacion_grupo/'+params[:id].to_s, :flash => { :info => "Sus invitaciones fueron enviadas."}
  end

  private
    def grupo_params
      params.require(:grupo).permit(:nombre, :descripcion, :estado, :llave)
    end

    def grupos
      if(params[:id] != nil && Grupo.find(params[:id]).habilitado)
       @grupo = Grupo.find(params[:id])
     else
       @grupo = Grupo.find(1)
    end
    end

    def redirigir_a(grupo)
      if grupo.estado==true
         redirect_to grupo, :flash => { :info => "Grupo creado exitosamente" }
      else
        redirect_to root_path, :flash => { :info => "Grupo creado exitosamente" }
      end
    end    
end
