require 'date'
class UsuariosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :require_log_in ,:only=>[:confirm,:new,:create,:forgot_password,:send_password_mail,:recover,:password_recovered]
  before_filter :grupos
  def index
  end

  def show
    @usuario=Usuario.find(params[:id])
  end
  def obtener_charla
    @user=Usuario.find(params[:usuario_id])
    @charla=Mensaje.find_all_by_de_usuario_id_and_para_usuario_id(params[:usuario_id],current_user.id)
    @charla_inversa=Mensaje.find_all_by_de_usuario_id_and_para_usuario_id(current_user.id,params[:usuario_id])

    @charla+=@charla_inversa
    @charla.each do |mensaje|
        mensaje.visto=true
        mensaje.save
    end
    @charla.sort!{|x,y|  x.created_at <=> y.created_at}
    render :layout => nil
  end

  def obtener_notificacion
    @comentario = TemaComentario.find_by_id(params[:comentario_id])
    @tema = Tema.find_by_id(params[:tema_id])
    @usuario = Usuario.find_by_id(params[:usuario_id])
    @lista_datos = [@comentario,@usuario,@tema]
    render :layout => nil;
  end

  def password_recovered
    if(current_user!=nil)
      redirect_to root_url
    else
      @request_id=params[:id_request]
      pass=params[:contrasenia_nueva].to_s
      newPass=params[:contrasenia_nueva2].to_s
      @usuario=Usuario.find(params[:id_user])
      if (pass==newPass)
        if(pass.length>5)
          @usuario.contrasenia=Digest::MD5.hexdigest(pass)
          @usuario.solicitud_contrasenia_id=-1
          @usuario.save
          #flash[:alert]=@usuario.correo+" "+pass+" "+@usuario.activa.to_s
          redirect_to root_url
        else
          @pass_error= 'la longitud minima es 6'
          render :action => 'recover',:format=>'html'
        end
      else
        @pass_error= 'Las contraseñas no coinciden'
        render :action => 'recover'
      end
    end
  end

  def edit
	 @usuario=current_user
  end

  def cambiar_email
    @usuario=current_user
  end

  def guardar_cambio_email
    if params[:correonuevo] != "" && params[:contrasenia] != ""
      otrousuario = Usuario.find_by(correo: params[:correonuevo])
      encriptado=Digest::MD5.hexdigest(params[:contrasenia].to_s)
      if otrousuario == nil
        if  current_user.contrasenia == encriptado
          usuario = current_user
          SendMail.cambiar_correo(usuario,params[:correonuevo]).deliver
          flash[:alert] = 'Necesita ver su correo para confirmar la operacion'
          redirect_to root_url
        else
          flash[:alert] = 'El password es incorrecto'
          redirect_to :back
        end
      else
        flash[:alert] = 'El correo que ingreso ya existe'
          redirect_to :back
      end
    else
      flash[:alert] = 'Necesita llenar los campos.'
      redirect_to :back
    end
  end

  def comfirmar_cambio_correo
    if(current_user==nil)
      flash[:alert] = "no puede confirma el cambio de correo electronico si esta loggeado"
    else
      usuario= Usuario.find(params[:id_user].to_s)
      flash[:alert] = "mierda"+usuario.nombre+params[:id_user].to_s+params[:correo].to_s;
      if(usuario.id==current_user.id)
        current_user.correo = params[:correo].to_s+".com"
        current_user.save 
        flash[:alert] = "Correo modificado con exito.";
      else
        flash[:alert] = "No se pudo modificar el correo.";
      end
    end
  end

  def update_password
    @usuario=current_user
  end

  def edit_password
    uno=params[:contrasenia_nueva].to_s
    dos=params[:contrasenia_nueva2].to_s
    encriptado=Digest::MD5.hexdigest(uno)
    contrasenia=params[:contrasenia].to_s
    if (contrasenia != uno && contrasenia != dos)
      contrasenia=Digest::MD5.hexdigest(contrasenia)
      if (current_user.contrasenia==contrasenia)
        if (uno==dos)        
          current_user.temp_password=encriptado
          current_user.save
          SendMail.change_password(current_user).deliver          
          flash[:alert] = 'Necesita ver su correo para confirmar la operacion'
          redirect_to root_url
        else
          flash[:alert] = 'Las contraseñas no coinciden'
          redirect_to :back
        end
      else
        flash[:alert] = 'La contraseña no es correcta'
        redirect_to :back
      end
    else      
      flash[:alert] = 'La nueva contraseña ingresada ya ha sido utilizada'
      redirect_to :back
    end
  end

  def confirm_change_password
    if(current_user==nil)
      flash[:alert] = "no puede confirma el cambio de contraseña si esta loggeado"
    else     
      #flash[:alert] = "mierda"+usuario.nombre+params[:id_user].to_s+params[:correo].to_s;
      if( current_user.temp_password == nil)
        flash[:alert] = "no tienes solicitudes pendintes"
      else
        usuario = Usuario.find(params[:id_user].to_s)      
        if(usuario.id==current_user.id)   
          uno=current_user.temp_password        
          current_user.contrasenia=uno
          current_user.temp_password=nil
          current_user.save        
          flash[:alert] = "Contraseña modificada con exito.";
        else
          flash[:alert] = "No se pudo modificar la contraseña.";        
        end
      end
    end     
  end

  def forgot_password
    if(current_user!=nil)
      redirect_to root_url
    end
  end

  def send_password_mail
    if(current_user==nil)
      mail=params[:mail]
      @usuario=Usuario.where(:correo=>mail,:activa=>true).first
      if(@usuario!=nil)
        if ( verify_recaptcha)
          p=SolicitudContrasenia.new(:usuario_id=>@usuario.id)
          p.save
          @usuario.solicitud_contrasenia_id=p.id
          @usuario.save
          SendMail.recover_password(@usuario,p.id).deliver
        else
          @pass_error = 'Ingrese las palabras correctamente'
        render :action => 'forgot_password', :format => 'html'
        end
      else
        @pass_error = 'No existe ningun usuario con ese correo'
        render :action => 'forgot_password', :format => 'html'
      end
    else
      redirect_to root_url
    end
  end

  def recover
    if(current_user!=nil)
       @errorMessagge="No puede recuperar su contraseña si esta loggeado"
    else
    begin
      password_request=SolicitudContrasenia.find(params[:id_request])
      rescue ActiveRecord::RecordNotFound
    end
      if(password_request!=nil && password_request.usuario.id.to_s==params[:id_user])
          if(password_request.usuario.solicitud_contrasenia_id==password_request.id && DateTime.now<=(password_request.created_at+(86400)))
            @request_id=password_request.id
             @usuario=password_request.usuario
          else
            @errorMessagge="Esta solicitud expiro, por favor solicite otra"
          end
      else
          @errorMessagge="No podemos procesar esta solicitud, por favor solicite otra"
      end
    end
  end

  def update
    current_user.nombre=params[:usuario][:nombre]
    current_user.apellido=params[:usuario][:apellido]
    if variable=params[:mostrarcorreo]
      current_user.mostrar_correo=true
    else
      current_user.mostrar_correo=false
    end
    if(current_user.save)
      flash[:alert] = 'Usuario Modificado'
    else
      flash[:alert] = current_user.errors.full_messages
    end
    redirect_to :action => 'edit', :format => 'html'
  end

  def new
  	@usuario = Usuario.new
  end

def confirm
  if(current_user==nil)
    @messagge="Error, datos invalidos"
  begin
    #usuario= Usuario.find(AESCrypt.decrypt(params[:pass].to_s,"Taller"))
    usuario= Usuario.find(params[:pass].to_s)
    rescue ActiveRecord::RecordNotFound
    rescue OpenSSL::Cipher::CipherError
 end
  if(usuario!=nil)
    if(!usuario.activa)
    usuario.activa=true
    usuario.save
    @messagge="Su cuenta fue activada exitosamente! ya puede hacer uso de nuestro contenido";
    end
  end
else
  @messagge="No puede activar su cuenta si esta loggeado";
end
end

def create
  	  params.permit!
  		@usuario = Usuario.new(params[:usuario])
      @usuario.rol=params[:rol]
      if variable=params[:mostrarcorreo]
        @usuario.mostrar_correo=true
      else
        @usuario.mostrar_correo=false
      end
  		if @usuario.save
        redirect_to root_url
        SendMail.activate_acount(@usuario).deliver
  			flash[:alert] = 'Usuario Registrado Exitosamente!!! Revise su correo electronico para activar la cuenta'
  			else
        render :new, :format => 'html'
  		end
  end
  
  def grupos
    if(params[:id] != nil && Grupo.find_by_id(params[:id]) && Grupo.find_by_id(params[:id]).habilitado)
     @grupo = Grupo.find(params[:id])
   else
     @grupo = Grupo.find(1)
  end
  end
end