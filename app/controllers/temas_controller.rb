class TemasController < ApplicationController
skip_before_filter :require_log_in,:only=>[:index,:search,:searchByDescription,:show,:searchtitulo]
before_filter :grupos
  def index
    @temas = @grupo.temas.order("updated_at DESC").page(params[:page]).per(5)
    @ides = sacarIds(@grupo.temas)
    @todosgrupos=Grupo.all
  end


  def buscar
    @temas = Array.new
    @grupo = Grupo.find(params[:grupo])
    aux = Tema.where(:grupo_id=>params[:grupo])
    if params[:search] != "" && params[:search] != nil
      byAll = Tema.allResultsSearchs(params[:search])
      @temas = byAll        
      @temas.each do |tema|
        if !tema.grupo.habilitado
          @temas.delete(tema)
        end
      end          
    end
    @ides=sacarIds(@temas)
    @temas= Kaminari.paginate_array(@temas).page(params[:page]).per(5)
    render 'index'
  end



  def ordertable
    @temas = Array.new
    if(params[:id] != nil)
      @grupo = Grupo.find(params[:id])
    else
      @grupo = Grupo.find(1)
    end
    if params[:themes] != nil && params[:themes] != ""
      @ids = params[:themes]
      @ids.slice!(0)
      @ids=@ids.split("-")
      @ids.each do |id|
        if id != "" && id != nil
          @temas.push(Tema.find(id))
        end
      end
      if params[:var] == "titulo"
        @temas.sort! { |a,b| a.titulo.downcase <=> b.titulo.downcase }
      else
        #@temas.sort! { |a,b| a.cuerpo.downcase <=> b.cuerpo.downcase }
        @temas.sort! { |a,b| a.created_at <=> b.created_at }
      end
    end
    @ides=sacarIds(@temas)
    @temas= Kaminari.paginate_array(@temas).page(params[:page]).per(5)
    render 'index'
  end

  def ordertablemine
    @temas = Array.new
    if params[:themes] != nil && params[:themes] != ""
      @ids = params[:themes]
      @ids.slice!(0)
      @ids=@ids.split("-")
      @ids.each do |id|
        if id != "" && id != nil
          @temas.push(Tema.find(id))
        end
      end
      if params[:var] == "titulo"
        @temas.sort! { |a,b| a.titulo.downcase <=> b.titulo.downcase }
      else
        if params[:var] == "fecha"
          #@temas.sort! { |a,b| a.cuerpo.downcase <=> b.cuerpo.downcase }
          @temas.sort! { |a,b| a.created_at <=> b.created_at }
        #else
         # @temas.sort! { |a,b| a.grupo.nombre.downcase <=> b.grupo.nombre.downcase }
        end
      end
    end
    render "show_mine"
  end

  public
  # GET /temas/new
  def new
    @tema = Tema.new
    @grupos = Array.new
    if(current_user!=nil)
      current_user.subscripcions.each do |subs|
        @grupos.push(subs.grupo)
      end
      @grupo = Grupo.find(params[:id])
      @id = params[:id]
    end
  end

  def show
    @tema = Tema.find(params[:id])
     notificaciones.each do |notificacion|
      if ( TemaComentario.find(notificacion.tema_comentario_id).tema_id == @tema.id )
        notificacion.notificado = true
        notificacion.save
      end
    end
     @comentarios= Kaminari.paginate_array(@tema.tema_comentarios).page(params[:page]).per(10)
  end

  # POST /temas
  def create
    @tema = Tema.new(tema_params)
    @tema.grupo_id=params[:tema][:grupo_id]
    @tema.usuario_id = current_user.id
    if @tema.save
      add_attached_files(@tema.id)
      flash[:alert] = 'Tema creado Exitosamente!'
      @suscripcion=SuscripcionTema.new
      @suscripcion.usuario_id=current_user.id
      @suscripcion.tema_id=@tema.id
      @suscripcion.save
      redirect_to '/temas/'
    else
      @grupos = Array.new
      if(current_user!=nil)
      current_user.subscripcions.each do |subs|
        @grupos.push(subs.grupo)
        end
        @grupo = Grupo.find(params[:tema][:grupo_id])
        @id = params[:tema][:grupo_id]
      end
      render 'new'
    end
  end

  private
    def add_attached_files(tema_id)
      if(!params[:tema][:archivo].nil?)
        params[:tema][:archivo].each do |arch|
        @archivo = ArchivoAdjuntoTema.new(:archivo=>arch)
        @archivo.tema_id = tema_id
        @archivo.save
        end
      end
    end

  public

  def edit
    @tema = Tema.find(params[:id])
  end

  def update
    @tema = Tema.find(params[:id])
    if(@tema.update(params[:tema].permit(:titulo,:cuerpo)))
      eliminar_archivos_adjuntos(params[:elemsParaElim])
      add_attached_files(@tema.id)
      redirect_to @tema
    else
      render 'edit'
    end
  end

  def eliminar_archivos_adjuntos(idsParaBorrar)
    if (!idsParaBorrar.nil?)
      idsParaBorrar.slice!(0)
       idsParaBorrar=idsParaBorrar.split("-")
       idsParaBorrar.each do |id|
           ArchivoAdjuntoTema.destroy(id)
       end
    end
  end

  def editar_comentario
    @comentario=TemaComentario.find(params[:id_comentario])
  end

  def visible
    @tema = Tema.find(params[:id])
    if(@tema.usuario_id == current_user.id)
      @tema.destroy
    end
    redirect_to temas_url
  end

  def show_mine
    todos_temas = Tema.all
    @temas = Array.new
    todos_temas.each do |tema|
      if(tema.usuario_id == current_user.id)
        @temas.push(tema)
      end
    end
    @ides=sacarIds(@temas)
    render "show_mine"
  end

  def searchmine
    @temas=Array.new
    aux = Tema.all
    if params[:titulo] != "" && params[:titulo] != nil
      aux.each do |tema|
        if (tema.correspondeATitulo(params[:titulo]))
          @temas.push(tema)
        end
      end
    else
      @temas = aux
    end
    /codigo agregado para busqueda por descripcion/
    if params[:descripcion] != "" && params[:descripcion] != nil
      byDescription = Tema.searchByDescription(params[:descripcion])
      if params[:titulo] == "" || params[:titulo] == nil
        @temas=byDescription
      else
        @temas = ((@temas&byDescription)+@temas+byDescription).uniq
      end
    end
    render "show_mine"
  end

  def search_main
    @temas=Array.new
    aux= Tema.all
    if params[:search] != "" && params[:search] != nil
      byAll = Tema.allResultsSearchs(params[:search])
      @temas = byAll
    end
    render "show_mine"
  end

  private
    # No permite parametros de internet
    def tema_params
      params.require(:tema).permit(:titulo, :cuerpo)
    end
    
    def grupos
      if(params[:id] != nil && Grupo.find(params[:id]).habilitado)
        @grupo = Grupo.find(params[:id])
      else
        @grupo = Grupo.find(1)
      end
    end

    def sacarIds(temas)
      concatenacion=""
      temas.each do |tema|
        concatenacion=concatenacion+"-"+tema.id.to_s
      end
      return concatenacion
    end
end