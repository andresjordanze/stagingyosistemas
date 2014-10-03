class Grupo < ActiveRecord::Base
  	belongs_to :usuario
  	has_many :temas
  	has_many :subscripcions
  	has_many :tareas
    has_many :cuestionarios
    has_many :eventos
  	validates :nombre, :presence => true
    delegate :nombre_usuario, :to => :usuario, :prefix => true
  	scope :buscar_mis_grupos,lambda { |user| where("usuario_id = ?", user.id)}
    validates :nombre, uniqueness: {case_sensitive: false, :message => ": Ya está en uso"}
    #validates :name, format: { with: /\A[a-zA-Z\d\s]+\z/, message: "Solo Letras Permitidas" }
    after_create :habilitar_grupo

    def habilitar_grupo
      self.habilitado = true
      self.save
    end

    def deshabilitar_grupo
      self.habilitado = false
      self.save
    end

    def self.all_habilitados
      Grupo.where(:habilitado => true)
    end

    def usuario_suscrito?(id)
  		resp = true
  		for suscripcion in self.subscripcions
  			if suscripcion.usuario_id == id
  				return resp = false
  			end
  		end
  		return resp
  	end

    def correspondeAGrupo(nombre)
      parametros = nombre.split(' ')
      parametros.each do |parametro|
         if self.nombre.downcase.include?(parametro.downcase)
           return true
         end
      end
      false
    end

    def correspondeLlaveAGrupo(llave)
      parametros llave.split(' ')
      parametros.each do |parametro|
         if self.llave.downcase.include?(parametro.downcase)
           return true
         end
      end
      false
    end

    #genera un string aleatorio
    def generar_llave
      cadena = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    llave = (0...6).map{ cadena[rand(cadena.length)] }.join
    llave
    end

    def verificar_grupo
      if self.estado == true
        self.llave = generar_llave
      else
        self.llave = "publico"
      end
    end


end
