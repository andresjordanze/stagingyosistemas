class Tema < ActiveRecord::Base
  has_many :tema_comentarios
  has_many :suscripcion_temas
  has_many :archivo_adjunto_temas
  belongs_to :usuario
  belongs_to :grupo
  validates :titulo, :cuerpo, :presence => { :message => " es requerido" }
  delegate :nombre_usuario, :correo, :to => :usuario, :prefix => true
  delegate :nombre, :to => :grupo, :prefix => true

  def correspondeATitulo(titulo)
    parametros = titulo.split(' ')
    parametros.each do |parametro|
       if self.titulo.downcase.include?(parametro.downcase)
         return true
       end
    end
    false
  end

  after_create do
    if(self.grupo==nil)
      grupo = Grupo.find(1)
      self.grupo = grupo
      self.save
    end
  end

  def self.searchByDescription(keyWords)
    keyWords = keyWords.downcase
      initialResult = Tema.where('cuerpo LIKE ?', '%'+keyWords+'%')
      deepResult = Tema.deepSearchOfDescription(keyWords)
      finalRes  = (initialResult+deepResult).uniq
      finalRes
  end

  def self.deepSearchOfDescription(keyWords)
    keyWordArray = keyWords.split
    keyWordArray = Tema.deleteIrrelevantWords(keyWordArray)
    keyWordArray.uniq!
    results=[]
    keyWordArray.each do |word|
      results<<Tema.where('cuerpo LIKE ?', '%'+word+'%')
    end
    finalResArray = results.flatten.uniq
    finalResArray
  end

  def self.searchBytitle(keyWords)
    keyWords = keyWords.downcase
    initialResult = Tema.where('titulo LIKE ?', '%'+keyWords+'%')
    deepResult = Tema.deepSearchOfDescription(keyWords)
    finalRes  = (initialResult+deepResult).uniq
    finalRes
  end

  def self.deepSearchOftitle(keyWords)
    keyWordArray = keyWords.split
    keyWordArray = Tema.deleteIrrelevantWords(keyWordArray)
    keyWordArray.uniq!
    results=[]
    keyWordArray.each do |word|
      results<<Tema.where('titulo LIKE ?', '%'+word+'%')
    end
    finalResArray = results.flatten.uniq
    finalResArray
  end

  def self.allResultsSearchs(keyWords)
    rTitle = searchBytitle(keyWords)
    rDescription = searchByDescription(keyWords)
    allResults = (rTitle+rDescription).uniq
  end

  def self.deleteIrrelevantWords(keyWordArray)
    res = keyWordArray - ["de", "a", "la", "el","los","en","al", "con", "que","por", "si","es","son"]
    i=0
    while(i<res.length)
      if(res[i].length<=3)
        res.delete_at(i)
      end
      i+=1
    end
    res
  end
end
