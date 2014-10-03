class Usuario < ActiveRecord::Base
require 'digest/md5'

	has_many :mensajes_recibidos, class_name:'Mensaje',inverse_of: :de_usuario
	has_many :mensajes_enviados, class_name:'Mensaje',inverse_of: :para_usuario
	has_many :temas
	has_many :tema_comentarios	
	has_many :subscripcions
	has_many :tareas
	has_many :suscripcion_temas
	has_many :eventos
	has_many :respuesta_usuarios
	has_many :cuestionarios
	  has_many :usuarios
  	  accepts_nested_attributes_for :usuarios
  	before_create :encrypt_password

	validates :nombre,
	:presence  => { :message => ": es requerido, no puede dejar vacio" },
	:length => {
		:minimum => 2, :message => ": minimo 2 letras",
		:allow_blank => TRUE
	}
	validates :apellido,
	:presence  => { :message => ": es requerido, no puede dejar vacio" },
	:length => {
		:minimum => 2, :message => ": minimo 2 letras",
		:allow_blank => TRUE
	}
	/validates :contrasenia, anterior version
	:presence  =>  { :message => " es requerido, no puede ser nulo" },
	:length => {
		:minimum =>  6 , :message => " minimo 6 caracteres"
	},
	:confirmation => TRUE/
  validates_confirmation_of :contrasenia, :message =>": no son iguales",
	:presence  =>  { :message => ": es requerida" },
	:length => {
		:minimum =>  6 , :message => ": minimo 6 caracteres"
	},
	:confirmation => TRUE
  
  validates_confirmation_of :contrasenia_de_confirmacion, :message => ": no son iguales"

	validates_format_of :correo,
	:presence => { :message => ": es requerido" },
	:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
	:message    => ': no valido'

	validates :nombre_usuario,
	:presence  =>  { :message => ": es requerido" },
	:uniqueness => { :message => ": ya esta siendo utilizado" }		

	validates :correo,
	:uniqueness =>{
		:message=> ": ya existente"
	}

	validates :nombre, format: {:multiline => true, with: /^[a-zA-Z ]+$/, message: ": no valido" }
	validates :apellido, format: {:multiline => true, with: /^[a-zA-Z ]+$/, message: ": no valido" }


	def self.autenticar(correo, contrasenia)
    	usuario = find_by_correo(correo)
    	if usuario && usuario.contrasenia == Digest::MD5.hexdigest(contrasenia) && usuario.activa==true
     		return usuario
    	end
    	usuario=find_by_nombre_usuario(correo)
    	if usuario && usuario.contrasenia == Digest::MD5.hexdigest(contrasenia) && usuario.activa==true
    		return usuario
    	else
    		return nil
    	end
    end
    def esta_subscrito?(grupo_id)
    	self.subscripcions.each do |subs|
    		if(subs.grupo_id==grupo_id.to_i)
    			return true
    		end
		end
		return false
    end

  	def encrypt_password
  		self.contrasenia = Digest::MD5.hexdigest(contrasenia)
  	end
  	after_create do
  		subscripcion = Subscripcion.new
        subscripcion.usuario = self
        subscripcion.grupo = Grupo.find_by_id(1)
        subscripcion.save
  	end
end