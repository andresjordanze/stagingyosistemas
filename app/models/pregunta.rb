class Pregunta < ActiveRecord::Base
  self.table_name = 'preguntas'
  belongs_to :cuestionario
  has_many :respuestas, :dependent => :destroy
  accepts_nested_attributes_for :respuestas, :reject_if => lambda{ |a| a[:texto].blank? }, :allow_destroy => true
end
